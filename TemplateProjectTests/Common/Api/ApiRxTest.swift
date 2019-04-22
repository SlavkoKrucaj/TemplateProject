import XCTest

@testable import TemplateProject
import Quick
import Nimble
import RxSwift
import SwiftyMocky
import OHHTTPStubs

//swiftlint:disable line_length
//swiftlint:disable function_body_length

class ApiRxTest: QuickSpec {
    override func spec() {
        var subject: Api!
        var requestFactory: UrlRequestFactoryMock!

        let disposeBag = DisposeBag()
        let exampleUrl = URL(string: "https://www.example.com")!

        beforeEach {
            requestFactory = UrlRequestFactoryMock()
            subject = Api(requestFactory: requestFactory)

            let urlRequest = URLRequest(url: exampleUrl)
            Given(requestFactory, .request(url: .value(exampleUrl), method: .value("GET"), headers: .any, body: .any, willReturn: urlRequest))
        }

        describe("load") {
            context("when request is valid", {
                context("when request result is back", {
                    describe("success", {
                        beforeEach {
                            stub(condition: isHost(exampleUrl.host!), response: { _ in
                                return OHHTTPStubsResponse(jsonObject: ["test": "testing"], statusCode: 200, headers: [:])
                            })
                        }

                        context("when parser not set", {
                            let request: Api.HTTPRequest<String> = Api.HTTPRequest.get(url: exampleUrl)

                            it("should propagate loading and correct error", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.error(.parserNotSet)),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })
                        })

                        context("when parsing successful", {
                            let request: Api.HTTPRequest<String> = Api.HTTPRequest.get(url: exampleUrl, headers: [:], parser: { _, _ in
                                return .empty
                            })

                            it("should propagate loading and content state", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.success(.empty)),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })
                        })

                        context("when parsing throws", {
                            let request: Api.HTTPRequest<String> = Api.HTTPRequest.get(url: exampleUrl, headers: [:], parser: { _, _ in
                                throw Api.ApiError.parsingFailure(TestError.test)
                            })

                            it("should propagate loading and error state", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.error(Api.ApiError.parsingFailure(TestError.test))),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })
                        })

                        afterEach {
                            OHHTTPStubs.removeAllStubs()
                        }
                    })

                    describe("network error", {
                        let request: Api.HTTPRequest<String> = Api.HTTPRequest.get(url: exampleUrl)

                        context("when offline", {
                            beforeEach {
                                let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(error: error)
                                })
                            }

                            it("should propagate loading and offline state", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.offline),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })

                            afterEach {
                                OHHTTPStubs.removeAllStubs()
                            }
                        })

                        context("when unhandled error", {
                            beforeEach {
                                let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(error: error)
                                })
                            }

                            it("should propagate loading and generic error", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.actionableError(.generic(NSURLErrorTimedOut), request)),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })

                            afterEach {
                                OHHTTPStubs.removeAllStubs()
                            }
                        })

                        context("when 4xx error", {
                            beforeEach {
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: [:])
                                })
                            }

                            it("should propagate loading and client error", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.error(.client(404))),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })

                            afterEach {
                                OHHTTPStubs.removeAllStubs()
                            }
                        })

                        context("when 5xx error", {
                            beforeEach {
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(data: Data(), statusCode: 500, headers: [:])
                                })
                            }

                            it("should propagate loading and server error", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.actionableError(.server(500), request)),
                                    .completed
                                ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })

                            afterEach {
                                OHHTTPStubs.removeAllStubs()
                            }
                        })

                        context("when unknown error", {
                            beforeEach {
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(data: Data(), statusCode: -1, headers: [:])
                                })
                            }

                            it("should propagate loading and unknown error", closure: {
                                let networkRecorder = NetworkRecorder<Api.ResponseStream<String>>(expectedEvents: [
                                    .next(.loading),
                                    .next(.actionableError(.unknown, request)),
                                    .completed
                                    ])
                                subject.rx_load(request: request).subscribe(networkRecorder).disposed(by: disposeBag)

                                self.wait(for: [networkRecorder.expectation], timeout: 5)
                            })

                            afterEach {
                                OHHTTPStubs.removeAllStubs()
                            }
                        })
                    })
                })
            })
        }
    }
}
