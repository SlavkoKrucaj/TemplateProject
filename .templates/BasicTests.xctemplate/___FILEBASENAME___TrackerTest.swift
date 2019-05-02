import Quick
import Nimble
import SwiftyMocky

@testable import ___PROJECTNAME___

class ___VARIABLE_moduleName___TrackerTest: QuickSpec {
    override func spec() {
        var subject: ___VARIABLE_moduleName___Tracker!

        var analyticsProvider: AnalyticsProviderInterfaceMock!

        beforeEach {
            analyticsProvider = AnalyticsProviderInterfaceMock()

            subject = ___VARIABLE_moduleName___Tracker(analyticsProvider: analyticsProvider, screenName: "___VARIABLE_moduleName___")
        }

        describe("track") {
            context("viewed", {
                it("should track viewed event", closure: {
                    subject.track(event: .viewed)
                    Verify(analyticsProvider, .log(event: .value("Viewed ___VARIABLE_moduleName___"), parameters: .any))
                })
            })
        }
    }
}
