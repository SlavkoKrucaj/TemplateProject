import Foundation

enum ___VARIABLE_moduleName___NavigationDestination {
}

enum ___VARIABLE_moduleName___TrackingEvent {
    case viewed
}

//sourcery: AutoMockable
public protocol ___VARIABLE_moduleName___WireframeInterface: WireframeInterface {
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___ViewInterface: class {
    func setTitle(title: String)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___PresenterInterface: class {
    func viewDidLoad()
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___InteractorInterface: class {
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___NavigationInterface: class {
    func navigate(to: ___VARIABLE_moduleName___NavigationDestination)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___TrackingInterface: class {
    func track(event: ___VARIABLE_moduleName___TrackingEvent)
}
