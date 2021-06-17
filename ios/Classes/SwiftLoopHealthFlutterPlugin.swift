import Flutter
import HealthKit
import LoopKit
import UIKit

public class SwiftLoopHealthFlutterPlugin: NSObject, FlutterPlugin, LHApi {
    let healthStore = HKHealthStore()
    let cacheStore = try! PersistenceController(directoryURL: FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true))
    var glucoseStore: GlucoseStore!
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger: FlutterBinaryMessenger = registrar.messenger()
    let api: LHApi = SwiftLoopHealthFlutterPlugin()
    LHApiSetup(messenger, api)
  }
    
    public func getGlucoseSamples(_ input: LHStoredGlucoseRequest?, completion: @escaping (LHStoredGlucoseResponse?, FlutterError?) -> Void) {
        if glucoseStore == nil {
            glucoseStore = GlucoseStore(healthStore: healthStore, cacheStore: cacheStore, cacheLength: TimeInterval(24), provenanceIdentifier: HKSource.default().bundleIdentifier)
        }
        glucoseStore.getGlucoseSamples(start: Date(timeIntervalSince1970: TimeInterval(input!.startTimestamp!)), end: (input!.endTimestamp != nil) ? Date(timeIntervalSince1970: TimeInterval(input!.endTimestamp!)) : Date()) { (result) in
            let serializedStoredGlucoseValues: [String]
            switch result {
            case .failure(_):
                // TODO: something intelligent.
                serializedStoredGlucoseValues = []
            case .success(let samples):
                serializedStoredGlucoseValues = samples.map({ s in
                    return String(s.startDate.timeIntervalSince1970) + "|" + String(s.quantity.doubleValue(for: HKUnit(from: "mg/dL"), withRounding: true))
                })
            }
            let response = LHStoredGlucoseResponse()
            response.serializedStoredGlucoseValues = serializedStoredGlucoseValues
            completion(response, nil)
        }
    }
}
