import Foundation

enum ___VARIABLE_moduleName___NavigationOption {
}

enum ___VARIABLE_moduleName___TrackingEvent {
    case viewed
}

protocol ___VARIABLE_moduleName___TrackingInterface: class {
    func track(event: ___VARIABLE_moduleName___TrackingEvent)
}

protocol ___VARIABLE_moduleName___WireframeInterface: WireframeInterface {
    func navigate(to option: ___VARIABLE_moduleName___NavigationOption)
}

protocol ___VARIABLE_moduleName___ViewInterface: class {
}

protocol ___VARIABLE_moduleName___PresenterInterface: class {
}

protocol ___VARIABLE_moduleName___InteractorInterface: class {
}
