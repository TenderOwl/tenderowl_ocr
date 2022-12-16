import Cocoa
import FlutterMacOS
import Vision

public class TenderowlOcrPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tenderowl_ocr", binaryMessenger: registrar.messenger)
    let instance = TenderowlOcrPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "extractTextFromImage":
      let results = processImage(path: call.arguments as! String)
      result(results)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func processImage(path: String) -> [String] {
    let url: CFURL = URL(fileURLWithPath: path) as CFURL
    guard let cgImageSource: CGImageSource = CGImageSourceCreateWithURL(url, nil) else { return [] }
    guard let cgImage: CGImage = CGImageSourceCreateImageAtIndex(cgImageSource, 0, nil) else { return [] }
    
    let request = VNRecognizeTextRequest()
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)
    
    do {
      // Perform the text-recognition request.
      try requestHandler.perform([request])
    } catch {
      print("Unable to perform the requests: \(error).")
    }
    
    let results = request.results?.compactMap { observation in
      return observation.topCandidates(1).first?.string
    }
    print(results!)
    return results ?? []
  }
}
