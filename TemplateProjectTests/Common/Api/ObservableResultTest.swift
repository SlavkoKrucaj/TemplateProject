import XCTest

import Quick
import Nimble
import RxSwift
import RxTest

import TemplateProject

//swiftlint:disable function_body_length

class ObservableResultTest: QuickSpec {
    override func spec() {
        describe("asSingleResult") {
            context("when successful response", {
                var items: Api.Result<String>!
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    items = Api.Result.items(["test"])
                    events = Observable.of(.loading, .success(items))
                }

                it("should return api result as a single items", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asSingleResult(stream: events).subscribe({ (event) in
                            expect(event).to(equal(SingleEvent.success(items)))
                        })
                })
            })

            context("when error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    events = Observable.of(.loading, .error(.unknown))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asSingleResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when actionable error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    let request = Api.Request<String>.get(url: URL(string: "www.google.com")!)
                    events = Observable.of(.loading, .actionableError(.unknown, request))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asSingleResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when observable error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    events = Observable.error(Api.ApiError.unknown)
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asSingleResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when two results come back", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    let items: Api.Result<String> = .empty
                    events = Observable.of(.loading, .success(items), .success(items))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asSingleResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })
        }

        describe("asUnwrappedResult") {
            context("when successful response", {
                context("when result is empty", {
                    context("when result is list", {
                        var events: Observable<Api.ResponseStream<String>>!

                        beforeEach {
                            let items: Api.Result<String> = .empty
                            events = Observable.of(.loading, .success(items))
                        }

                        it("should return api result as a single items", closure: {
                            _ = Observable<Api.ResponseStream<String>>
                                .asUnwrappedResult(stream: events).subscribe(onSuccess: { (result) in
                                    expect(result).to(equal([]))
                                })
                        })
                    })
                })

                context("when result is list", {
                    var events: Observable<Api.ResponseStream<String>>!

                    beforeEach {
                        let items: Api.Result<String> = .items(["test"])
                        events = Observable.of(.loading, .success(items))
                    }

                    it("should return api result as a single items", closure: {
                        _ = Observable<Api.ResponseStream<String>>
                            .asUnwrappedResult(stream: events).subscribe(onSuccess: { (result) in
                                expect(result).to(equal(["test"]))
                            })
                    })
                })

                context("when result is paginated list", {
                    var events: Observable<Api.ResponseStream<String>>!

                    beforeEach {
                        let request = Api.Request<String>.get(url: URL(string: "www.google.com")!)
                        let items = Api.Result.multiplePage(["test"], request)
                        events = Observable.of(.loading, .success(items))
                    }

                    it("should return api result as a single items", closure: {
                        _ = Observable<Api.ResponseStream<String>>
                            .asUnwrappedResult(stream: events).subscribe(onSuccess: { (result) in
                                expect(result).to(equal(["test"]))
                            })
                    })
                })
            })

            context("when error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    events = Observable.of(.loading, .error(.unknown))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asUnwrappedResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when actionable error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    let request = Api.Request<String>.get(url: URL(string: "www.google.com")!)
                    events = Observable.of(.loading, .actionableError(.unknown, request))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asUnwrappedResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when observable error happens", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    events = Observable.error(Api.ApiError.unknown)
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asUnwrappedResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })

            context("when two results come back", {
                var events: Observable<Api.ResponseStream<String>>!

                beforeEach {
                    let items: Api.Result<String> = .empty
                    events = Observable.of(.loading, .success(items), .success(items))
                }

                it("should error", closure: {
                    _ = Observable<Api.ResponseStream<String>>
                        .asUnwrappedResult(stream: events).subscribe(onError: { _ in
                            expect(true).to(beTrue())
                        })
                })
            })
        }
    }
}
