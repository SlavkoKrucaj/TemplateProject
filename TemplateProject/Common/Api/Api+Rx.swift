import Foundation

import RxSwift

extension Api {
    func rx_load<T>(request: HTTPRequest<T>) -> Observable<Api.Stream<T>> {
        return Observable.create({ (subscriber) -> Disposable in
            let sessionTask = self.load(request, stateCallback: { (state) in
                subscriber.onNext(state)
                switch (state) {
                case .error, .offline, .success: subscriber.onCompleted()
                default: break
                }
            })
            return Disposables.create {
                sessionTask?.cancel()
            }
        }).observeOn(MainScheduler.instance)
    }
}

extension Observable {
    enum ResultUnwrapingError: Error {
        case internalInconsistency
    }

    static func asSingleResult<T>(stream: Observable<Api.Stream<T>>) -> Single<Api.Result<T>> {
        return stream.filter({ (item) -> Bool in
            switch (item) {
                case .success, .error: return false
                default: return true
            }
        }).flatMap({ item -> Observable<Api.Result<T>> in
            switch (item) {
                case .success(let result): return Observable<Api.Result<T>>.just(result)
                case .error(let error, _): return Observable<Api.Result<T>>.error(error)
                default: return Observable<Api.Result<T>>.error(ResultUnwrapingError.internalInconsistency)
            }
        }).asSingle()
    }

    static func asUnwrappedResult<T>(stream: Observable<Api.Stream<T>>) -> Single<[T]> {
        return Observable.asSingleResult(stream: stream).map({ result in
            return result.unwrap()
        })
    }
}

private extension Api.Result where T: Any {
    func unwrap() -> [T] {
        switch (self) {
            case .empty: return []
            case .items(let items): return items
            case .multiplePage(let items, _): return items
        }
    }
}
