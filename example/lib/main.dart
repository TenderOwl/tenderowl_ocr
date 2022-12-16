import 'package:clipboard/clipboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tenderowl_ocr/tenderowl_ocr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? filepath;
  String? extractedText;
  final tenderowlOcrPlugin = TenderowlOcr();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 33, 20, 14)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: onOpenImage,
                    child: Row(
                      children: const [
                        Icon(Icons.file_open_outlined),
                        Text('Open image')
                      ],
                    ),
                  ),
                  if (filepath != null)
                    Builder(builder: (context) {
                      return Row(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              await FlutterClipboard.copy(
                                      'hello flutter friends')
                                  .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Copied!')),
                                ),
                              );
                            },
                            child: Row(children: const [
                              Icon(Icons.copy_outlined),
                              Text('Copy')
                            ]),
                          ),
                          MaterialButton(
                            onPressed: onClean,
                            child: Row(children: const [
                              Icon(Icons.delete_outlined),
                              Text('Clean')
                            ]),
                          ),
                        ],
                      );
                    })
                ],
              ),
            ),
            Expanded(
              child: extractedText == null
                  ? const Center(child: Text('Open image to extract text'))
                  : SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          extractedText!,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )),
            )
          ],
        ),
      ),
    );
  }

  Future onOpenImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final lines = await tenderowlOcrPlugin
          .extractTextFromImage(result.files.single.path!);
      if (lines != null) {
        setState(() {
          filepath = result.files.single.path!;
          extractedText = lines.join('\n');
        });
      }
    }
  }

  void onClean() {
    setState(() {
      filepath = null;
      extractedText = null;
    });
  }

  Future onCopy() async {
    if (extractedText == null) return;
    await FlutterClipboard.copy(extractedText!).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied!')),
      ),
    );
  }
}
