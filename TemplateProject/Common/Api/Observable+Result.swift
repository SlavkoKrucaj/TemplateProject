import Foundation

import RxSwift

extension Observable {
    public enum ResultUnwrapingError: Error {
        case internalInconsistency
    }

    public static func asSingleResult<T>(stream: Observable<Api.ResponseStream<T>>) -> Single<Api.Result<T>> {
        return stream.filter({ (item) -> Bool in
            switch (item) {
            case .success, .error, .actionableError: return true
            default: return false
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

    public static func asUnwrappedResult<T>(stream: Observable<Api.ResponseStream<T>>) -> Single<[T]> {
        return Observable.asSingleResult(stream: stream).map({ result in
            return result.unwrap()
        })
    }
}
