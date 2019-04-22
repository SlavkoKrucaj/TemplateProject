import Foundation

import RxSwift

extension HttpLoader {
    func rx_load<T>(request: Api.HTTPRequest<T>) -> Observable<Api.ResponseStream<T >> {
        return Observable.create({ (subscriber) -> Disposable in
            let sessionTask = self.load(request, stateCallback: { (state) in
                subscriber.onNext(state)
                switch (state) {
                case .error, .actionableError, .offline, .success: subscriber.onCompleted()
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

    static func asSingleResult<T>(stream: Observable<Api.ResponseStream<T>>) -> Single<Api.Result<T>> {
        return stream.filter({ (item) -> Bool in
            switch (item) {
                case .success, .error, .actionableError: return false
                default: return true
            }
        }).flatMap({ item -> Observable<Api.Result<T>> in
            switch (item) {
                case .success(let result): return Observable<Api.Result<T>>.just(result)
                case .actionableError(let error, _): return Observable<Api.Result<T>>.error(error)
                case .error(let error): return Observable<Api.Result<T>>.error(error)
                default: return Observable<Api.Result<T>>.error(ResultUnwrapingError.internalInconsistency)
            }
        }).asSingle()
    }

    static func asUnwrappedResult<T>(stream: Observable<Api.ResponseStream<T>>) -> Single<[T]> {
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
