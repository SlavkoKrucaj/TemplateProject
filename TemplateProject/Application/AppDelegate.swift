import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let initialController = UINavigationController()
//        initialController.setRootWireframe(FirstWireframe())

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()

        return true
    }
}
