import Foundation

public struct DebugAnalyticsProvider: AnalyticsProviderInterface {
    public func log(event: String, parameters: [String: Any]?) {
        print("Event: \(event) with params: \(String(describing: parameters))")
    }
}
