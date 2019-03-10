import Foundation

import RxSwift

extension Api {
    func rx_load<T>(request: HTTPRequest<T>) -> Observable<Api.State<T>> {
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
