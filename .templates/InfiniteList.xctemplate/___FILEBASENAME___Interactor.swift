import Foundation

import RxSwift

final class ___VARIABLE_moduleName___Interactor: ___VARIABLE_moduleName___InteractorInterface {
    func load(_ request: Api.HTTPRequest<T>?) -> Observable<Api.State<T>> {
        return Observable.just(Api.State.loading)
    }
}
