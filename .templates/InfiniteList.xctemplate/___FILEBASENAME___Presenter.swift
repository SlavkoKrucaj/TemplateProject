import Foundation

import IGListKit
import RxSwift

final class ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterInterface {
    private unowned var view: ___VARIABLE_moduleName___ViewInterface
    private let interactor: ___VARIABLE_moduleName___InteractorInterface
    private let tracker: ___VARIABLE_moduleName___Tracker
    private let wireframe: ___VARIABLE_moduleName___WireframeInterface
    private let stateProvider: StateProvider
    private let disposeBag: DisposeBag = DisposeBag()

    var items: [ListDiffable] = [] {
        didSet {
            self.view.refreshView()
        }
    }

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

    func load() {
        self.load(self.interactor.load(nil), mapper: self.mapInitialState)
    }

    func loadMore() {
        self.load(self.interactor.load(self.nextRequest()), mapper: self.mapNextState)
    }

    private func load(_ requestObservable: Observable<Api.Stream<DomainModel>>,
                      mapper: @escaping (Api.Stream<DomainModel>) -> [ListDiffable]) {
        requestObservable.map(mapper).subscribe { [weak self] event in
            switch (event) {
            case .next(let items): self?.items = items
            case .completed: break
            case .error(let error): fatalError("Error while loading content for ___VARIABLE_moduleName___ \(error)")
            }
        }.disposed(by: self.disposeBag)
    }

    private func mapInitialState(state: Api.Stream<DomainModel>) -> [ListDiffable] {
        var items: [ListDiffable] = []
        switch (state) {
        case .loading:
            items.append(self.stateProvider.loading())
        case .error:
            items.append(self.stateProvider.error())
        case .offline:
            items.append(self.stateProvider.offline())
        case .success(.empty):
            items.append(self.stateProvider.empty())
        case .success(.items(let content)):
            items.append(contentsOf: content.map(CellViewModel.init))
        case .success(.multiplePage(let content, let apiRequest)):
            items.append(contentsOf: content.map(CellViewModel.init))
            items.append(self.stateProvider.loadMore(request: apiRequest))
        }
        return items
    }

    private func mapNextState(state: Api.Stream<DomainModel>) -> [ListDiffable] {
        var tmp: [ListDiffable] = self.items
        switch (state) {
        case .error, .offline, .success(.empty):
            tmp = self.removeLoadMore(from: tmp)
        case .success(.items(let items)):
            tmp = self.removeLoadMore(from: tmp)
            tmp.append(contentsOf: items.map(CellViewModel.init))
        case .success(.multiplePage(let items, let apiRequest)):
            tmp = self.removeLoadMore(from: tmp)
            tmp.append(contentsOf: items.map(CellViewModel.init))
            tmp.append(self.stateProvider.loadMore(request: apiRequest))
        default:
            break
        }
        return tmp
    }

    private func nextRequest() -> Api.HTTPRequest<DomainModel> {
        return self.items
            .compactMap { $0 as? LoadMoreModel<DomainModel> }
            .map { $0.apiRequest }
            .first!
    }

    private func removeLoadMore(from items: [ListDiffable]) -> [ListDiffable] {
        return items.filter { !($0 is LoadMoreModel<DomainModel>) }
    }
}
