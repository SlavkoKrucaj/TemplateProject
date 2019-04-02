import Foundation

class TestScreenTracker: TestScreenTrackingInterface {
    private let screenName: String

    init(screenName: String) {
        self.screenName = screenName
    }

    func track(event: TestScreenTrackingEvent) {
        switch (event) {
        case .viewed: NSLog("Tracking Viewed Screen: \(screenName)")
        }
    }
}
