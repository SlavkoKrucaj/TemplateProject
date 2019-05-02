import Foundation

//sourcery: AutoMockable
public protocol AnalyticsProviderInterface {
    func log(event: String, parameters: [String: Any]?)
}
