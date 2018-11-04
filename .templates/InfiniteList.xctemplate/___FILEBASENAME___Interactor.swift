import Foundation

import RxSwift

final class ___VARIABLE_moduleName___Interactor: ___VARIABLE_moduleName___InteractorInterface {
    func load(_ request: Api.HTTPRequest<T>?) -> Observable<Api.Stream<T>> {
        return Observable.just(Api.Stream.loading)
    }
}
