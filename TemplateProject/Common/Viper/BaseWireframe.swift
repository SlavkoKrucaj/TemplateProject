import Foundation
import UIKit

//sourcery: AutoMockable
public protocol WireframeInterface: class {
    func dismiss(animated: Bool)
}

public class BaseWireframe: WireframeInterface {
    fileprivate unowned var _viewController: UIViewController

    //to retain view controller reference upon first access
    fileprivate var temporaryStoredViewController: UIViewController?

    public init(viewController: UIViewController) {
        self.temporaryStoredViewController = viewController
        self._viewController = viewController
    }

    public var viewController: UIViewController {
        defer { self.temporaryStoredViewController = nil }
        return self._viewController
    }

    public var navigationController: UINavigationController? {
        return _viewController.navigationController
    }

    public func dismiss(animated: Bool) {
        self.viewController.dismiss(animated: true)
    }
}

extension UIViewController {
    public func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    public func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

extension UIStoryboard {
    //swiftlint:disable force_cast
    public func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    //swiftlint:enable force_cast
}
