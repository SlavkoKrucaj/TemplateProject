import Foundation

final class ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterInterface {
    private let wireframe: ___VARIABLE_moduleName___WireframeInterface
    private unowned var view: ___VARIABLE_moduleName___ViewInterface
    private let interactor: ___VARIABLE_moduleName___InteractorInterface
    private let tracker: ___VARIABLE_moduleName___TrackingInterface
    private let navigator: ___VARIABLE_moduleName___NavigationInterface
    private let translator: TranslatorInterface
    private let stateProvider: StateProviderInterface

    init(wireframe: ___VARIABLE_moduleName___WireframeInterface,
         view: ___VARIABLE_moduleName___ViewInterface,
         interactor: ___VARIABLE_moduleName___InteractorInterface,
         tracker: ___VARIABLE_moduleName___TrackingInterface,
         navigator: ___VARIABLE_moduleName___NavigationInterface,
         translator: TranslatorInterface,
         stateProvider: StateProviderInterface = BasicStateProvider()) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.tracker = tracker
        self.navigator = navigator
        self.translator = translator
        self.stateProvider = stateProvider
    }

    func viewDidLoad() {
        self.tracker.track(event: .viewed)
        self.view.setTitle(title: self.translator.translate("title"))
    }
}
