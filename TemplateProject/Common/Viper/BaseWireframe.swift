import Foundation
import UIKit

//sourcery: AutoMockable
protocol WireframeInterface: class {
    func dismiss(animated: Bool)
}

class BaseWireframe: WireframeInterface {
    fileprivate unowned var _viewController: UIViewController

    //to retain view controller reference upon first access
    fileprivate var temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        self.temporaryStoredViewController = viewController
        self._viewController = viewController
    }

    var viewController: UIViewController {
        defer { self.temporaryStoredViewController = nil }
        return self._viewController
    }

    var navigationController: UINavigationController? {
        return _viewController.navigationController
    }

    func dismiss(animated: Bool) {
        self.viewController.dismiss(animated: true)
    }
}

extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

extension UIStoryboard {
    //swiftlint:disable force_cast
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    //swiftlint:enable force_cast
}
