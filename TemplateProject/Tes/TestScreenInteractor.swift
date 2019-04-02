import Foundation

import RxSwift

final class TestScreenInteractor: TestScreenInteractorInterface {
    func load(_ request: Api.HTTPRequest<T>?) -> Observable<Api.State<T>> {
        return Observable.just(Api.State.loading)
    }
}
