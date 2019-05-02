import UIKit

import Crashlytics
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])

        let initialController = UINavigationController()
//        initialController.setRootWireframe(...Wireframe())

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()

        return true
    }
}
