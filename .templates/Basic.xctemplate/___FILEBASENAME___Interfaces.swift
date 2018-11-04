import Foundation

enum ___VARIABLE_moduleName___NavigationOption {
}

enum ___VARIABLE_moduleName___TrackingEvent {
    case viewed
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___TrackingInterface: class {
    func track(event: ___VARIABLE_moduleName___TrackingEvent)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___WireframeInterface: WireframeInterface {
    func navigate(to option: ___VARIABLE_moduleName___NavigationOption)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___ViewInterface: class {
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___PresenterInterface: class {
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___InteractorInterface: class {
}
