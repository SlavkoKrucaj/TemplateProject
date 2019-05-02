import Quick
import Nimble
import SwiftyMocky

@testable import ___PROJECTNAME___

class ___VARIABLE_moduleName___PresenterTest: QuickSpec {
    override func spec() {
        var subject: ___VARIABLE_moduleName___Presenter!

        var wireframe: ___VARIABLE_moduleName___WireframeInterfaceMock!
        var view: ___VARIABLE_moduleName___ViewInterfaceMock!
        var interactor: ___VARIABLE_moduleName___InteractorInterfaceMock!
        var tracker: ___VARIABLE_moduleName___TrackingInterfaceMock!
        var navigator: ___VARIABLE_moduleName___NavigationInterfaceMock!
        var translator: TranslatorInterfaceMock!
        var stateProvider: StateProviderInterfaceMock!

        beforeEach {
            wireframe = ___VARIABLE_moduleName___WireframeInterfaceMock()
            view = ___VARIABLE_moduleName___ViewInterfaceMock()
            interactor = ___VARIABLE_moduleName___InteractorInterfaceMock()
            tracker = ___VARIABLE_moduleName___TrackingInterfaceMock()
            navigator = ___VARIABLE_moduleName___NavigationInterfaceMock()
            translator = TranslatorInterfaceMock()
            stateProvider = StateProviderInterfaceMock()

            subject = ___VARIABLE_moduleName___Presenter(wireframe: wireframe,
                                         view: view,
                                         interactor: interactor,
                                         tracker: tracker,
                                         navigator: navigator,
                                         translator: translator,
                                         stateProvider: stateProvider)
        }

        describe("viewDidLoad") {
            let screenName = "Screen Name"

            beforeEach {
                Given(translator, .translate(.value("title"), willReturn: screenName))
            }

            it("should set title on the view", closure: {
                subject.viewDidLoad()
                Verify(view, .setTitle(title: .value(screenName)))
            })

            it("should track viewed event", closure: {
                subject.viewDidLoad()
                Verify(tracker, .track(event: .value(.viewed)))
            })
        }
    }
}
