import Foundation

final class ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterInterface {
    private unowned var view: ___VARIABLE_moduleName___ViewInterface
    private let interactor: ___VARIABLE_moduleName___InteractorInterface
    private let tracker: ___VARIABLE_moduleName___Tracker
    private let wireframe: ___VARIABLE_moduleName___WireframeInterface
    private let stateProvider: StateProvider

    init(wireframe: ___VARIABLE_moduleName___WireframeInterface,
         view: ___VARIABLE_moduleName___ViewInterface,
         interactor: ___VARIABLE_moduleName___InteractorInterface,
         tracker: ___VARIABLE_moduleName___Tracker,
         stateProvider: StateProvider = StateProvider()) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.stateProvider = stateProvider
        self.tracker = tracker
    }
}
