import XCTest

import Quick
import Nimble
import OHHTTPStubs
import SwiftyMocky

import TemplateProject

//swiftlint:disable line_length
//swiftlint:disable function_body_length

final class ApiTest: QuickSpec {
    override func spec() {
        var subject: Api!
        var requestFactory: UrlRequestFactoryMock!

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
                            let request: Api.Request<String> = Api.Request.get(url: exampleUrl)

                            it("should propagate loading and correct error", closure: {
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .error(.parserNotSet)
                                ])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
                            })
                        })

                        context("when parsing successful", {
                            let request: Api.Request<String> = Api.Request.get(url: exampleUrl, headers: [:], parser: { _, _ in
                                return .empty
                            })

                            it("should propagate loading and content state", closure: {
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .success(.empty)
                                ])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
                            })
                        })

                        context("when parsing throws", {
                            let request: Api.Request<String> = Api.Request.get(url: exampleUrl, headers: [:], parser: { _, _ in
                                throw Api.ApiError.parsingFailure(TestError.test)
                            })

                            it("should propagate loading and error state", closure: {
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .error(Api.ApiError.parsingFailure(TestError.test))
                                ])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
                            })
                        })

                        afterEach {
                            OHHTTPStubs.removeAllStubs()
                        }
                    })

                    describe("network error", {
                        let request: Api.Request<String> = Api.Request.get(url: exampleUrl)

                        context("when offline", {
                            beforeEach {
                                let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)
                                stub(condition: isHost(exampleUrl.host!), response: { _ in
                                    return OHHTTPStubsResponse(error: error)
                                })
                            }

                            it("should propagate loading and offline state", closure: {
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [.loading, .offline])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
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
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [.loading, .actionableError(.generic(NSURLErrorTimedOut), request)])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
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
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .error(Api.ApiError.client(404))
                                ])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
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
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .actionableError(Api.ApiError.server(500), request)
                                ])

                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })

                                self.wait(for: [recorder.expectation], timeout: 5)
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
                                let recorder = ClosureRecorder<Api.ResponseStream<String>>(values: [
                                    .loading,
                                    .actionableError(Api.ApiError.unknown, request)
                                ])
                                _ = subject.load(request, stateCallback: { state in
                                    recorder.verify(state)
                                })
                                self.wait(for: [recorder.expectation], timeout: 5)
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
