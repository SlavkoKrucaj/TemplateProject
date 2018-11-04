import Foundation

class ___VARIABLE_moduleName___Tracker: ___VARIABLE_moduleName___TrackingInterface {
    private let screenName: String

    init(screenName: String) {
        self.screenName = screenName
    }

    func track(event: ___VARIABLE_moduleName___TrackingEvent) {
        switch (event) {
        case .viewed: NSLog("Tracking Viewed Screen: \(screenName)")
        }
    }
}
