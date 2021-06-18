import Flutter
import HealthKit
import LoopKit
import UIKit

public class SwiftLoopHealthFlutterPlugin: NSObject, FlutterPlugin, LHApi, GlucoseStoreDelegate {
    private var callbackApi: LHCallbackApi!
    private let healthStore = HKHealthStore()
    private let cacheStore = try! PersistenceController(directoryURL: FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true))
    private var glucoseStore: GlucoseStore!
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let api: LHApi = SwiftLoopHealthFlutterPlugin(messenger)
        LHApiSetup(messenger, api)
    }
    
    init(_ binaryMessenger: FlutterBinaryMessenger) {
        self.callbackApi = LHCallbackApi(binaryMessenger: binaryMessenger)
    }
    
    public func listen(forHealthData error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if glucoseStore == nil {
            glucoseStore = GlucoseStore(healthStore: healthStore, cacheStore: cacheStore, cacheLength: TimeInterval(24 * 60 * 60), provenanceIdentifier: HKSource.default().bundleIdentifier)
        }
        glucoseStore.delegate = self
        let typesToObserve = Set([glucoseStore.sampleType])
        healthStore.requestAuthorization(toShare: typesToObserve, read: typesToObserve) { (success, error) in
            if success {
                self.glucoseStore.authorize(toShare: true) { _ in }
            }
        }
    }
    
    public func getGlucoseSamples(_ input: LHStoredGlucoseRequest?, completion: @escaping (LHStoredGlucoseResponse?, FlutterError?) -> Void) {
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
    
    // MARK: -- GlucoseStoreDelegate
    public func glucoseStoreHasUpdatedGlucoseData(_ glucoseStore: GlucoseStore) {
        let sample = LHStoredGlucoseSample()
        sample.timestamp = glucoseStore.latestGlucose!.startDate.timeIntervalSince1970 as NSNumber
        sample.quantity = NSNumber(value: Int(glucoseStore.latestGlucose!.quantity.doubleValue(for: HKUnit(from: "mg/dL"), withRounding: true)))
        DispatchQueue.main.async {
            self.callbackApi.newSample(sample) { error in }
        }
    }
}
