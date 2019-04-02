import Foundation
import UIKit

final class TestScreenWireframe: BaseWireframe, TestScreenWireframeInterface {
    private let _storyboard = UIStoryboard(name: "TestScreen", bundle: nil)

    init() {
        let moduleViewController = _storyboard.instantiateViewController(ofType: TestScreenViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = TestScreenInteractor()
        let tracker = TestScreenTracker(screenName: "TestScreen")
        let presenter = TestScreenPresenter(wireframe: self, view: moduleViewController, interactor: interactor, tracker: tracker)
        moduleViewController.presenter = presenter
    }

    func navigate(to option: TestScreenNavigationOption) {

    }
}
