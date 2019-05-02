import Foundation

final class ___VARIABLE_moduleName___Tracker: ___VARIABLE_moduleName___TrackingInterface {
    private let analyticsProvider: AnalyticsProviderInterface
    private let screenName: String

    init(analyticsProvider: AnalyticsProviderInterface, screenName: String) {
        self.analyticsProvider = analyticsProvider
        self.screenName = screenName
    }

    func track(event: ___VARIABLE_moduleName___TrackingEvent) {
        switch (event) {
        case .viewed: analyticsProvider.log(event: "Viewed \(self.screenName)", parameters: [:])
        }
    }
}
