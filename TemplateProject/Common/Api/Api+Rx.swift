import Foundation

import RxSwift

extension Api: ReactiveCompatible { }

extension HttpLoader {
    var rx: RxSwift.Reactive<HttpLoader> {
        return RxSwift.Reactive<HttpLoader>(self)
    }
}

public extension Reactive where Base == HttpLoader {
    func load<T>(request: Api.Request<T>) -> Observable<Api.ResponseStream<T>> {
        return Observable.create({ (subscriber) -> Disposable in
            let sessionTask = self.base.load(request, stateCallback: { (state) in
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
