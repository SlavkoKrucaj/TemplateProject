import Foundation
import UIKit

final class ___VARIABLE_moduleName___Wireframe: BaseWireframe, ___VARIABLE_moduleName___WireframeInterface {
    private let _storyboard = UIStoryboard(name: "___VARIABLE_moduleName___", bundle: nil)

    init() {
        let moduleViewController = _storyboard.instantiateViewController(ofType: ___VARIABLE_moduleName___ViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = ___VARIABLE_moduleName___Interactor()
        let tracker = ___VARIABLE_moduleName___Tracker(screenName: "___VARIABLE_moduleName___")
        let presenter = ___VARIABLE_moduleName___Presenter(wireframe: self, view: moduleViewController, interactor: interactor, tracker: tracker)
        moduleViewController.presenter = presenter
    }

    func navigate(to option: ___VARIABLE_moduleName___NavigationOption) {

    }
}
