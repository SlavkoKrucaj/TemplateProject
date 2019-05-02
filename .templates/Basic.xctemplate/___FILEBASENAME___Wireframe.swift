import Foundation
import UIKit

final public class ___VARIABLE_moduleName___Wireframe: BaseWireframe, ___VARIABLE_moduleName___WireframeInterface {
    private struct Constants {
        static let screen = "___VARIABLE_moduleName___"
    }

    private let _storyboard = UIStoryboard(name: Constants.screen, bundle: nil)

    public init(analyticsProvider: AnalyticsProviderInterface) {
        let moduleViewController = _storyboard.instantiateViewController(ofType: ___VARIABLE_moduleName___ViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = ___VARIABLE_moduleName___Interactor()
        let tracker = ___VARIABLE_moduleName___Tracker(analyticsProvider: analyticsProvider, screenName: Constants.screen)
        let navigator = ___VARIABLE_moduleName___Navigator()
        let translator = Translator(bundle: Bundle(for: type(of: self)), tableName: Constants.screen)
        let presenter = ___VARIABLE_moduleName___Presenter(wireframe: self,
                                                           view: moduleViewController,
                                                           interactor: interactor,
                                                           tracker: tracker,
                                                           navigator: navigator,
                                                           translator: translator)
        moduleViewController.presenter = presenter
    }
}
