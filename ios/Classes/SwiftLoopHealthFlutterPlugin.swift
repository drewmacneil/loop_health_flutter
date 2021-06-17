import Flutter
import UIKit
import LoopKit

public class SwiftLoopHealthFlutterPlugin: NSObject, FlutterPlugin, LHApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger: FlutterBinaryMessenger = registrar.messenger()
    let api: LHApi = SwiftLoopHealthFlutterPlugin()
    LHApiSetup(messenger, api)
  }

  public func getPlatformVersion(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> LHVersion? {
    let version = LHVersion.init()
    version.string = "iOS " + UIDevice.current.systemVersion
    return version
  }
}
