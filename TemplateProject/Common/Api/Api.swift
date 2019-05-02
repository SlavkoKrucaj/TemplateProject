import Foundation

public typealias JsonDictionary = [String: Any]

//sourcery: AutoMockable
public protocol HttpLoader {
    func load<ResultType>(_ request: Api.Request<ResultType>,
                          stateCallback: @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> URLSessionTask?
}

public final class Api: HttpLoader {
    public enum ApiError: Error {
        case unknown
        case generic(Int)
        case client(Int)
        case server(Int)
        case parsingFailure(Error)
        case parserNotSet
        case responseWithNoData
    }

    public enum ResponseStream<T> {
        case loading
        case success(Result<T>)
        case actionableError(ApiError, Request<T>)
        case error(ApiError)
        case offline
    }

    public enum Result<T> {
        case empty
        case items([T])
        case multiplePage([T], Request<T>)

        func unwrap() -> [T] {
            switch (self) {
            case .empty: return []
            case .items(let items): return items
            case .multiplePage(let items, _): return items
            }
        }
    }

    public struct Request<T> {
        let method: String
        let url: URL
        let headers: [String: String]
        let body: Data?
        let parser: ((Data, Request<T>) throws -> Result<T>)?

        public static func get(url: URL,
                               headers: [String: String] = [:],
                               parser: ((Data, Request<T>) throws -> Result<T>)? = nil) -> Request {
            return Request(method: "GET", url: url, headers: headers, body: nil, parser: parser)
        }

        private init(method: String,
                     url: URL,
                     headers: [String: String] = [:],
                     body: Data? = nil,
                     parser: ((Data, Request<T>) throws -> Result<T>)? = nil) {
            self.method = method
            self.url = url
            self.headers = headers
            self.body = body
            self.parser = parser
        }
    }

    private let requestFactory: UrlRequestFactory

    public init(requestFactory: UrlRequestFactory = BasicUrlRequestFactory()) {
        self.requestFactory = requestFactory
    }

    public func load<T>(_ request: Request<T>, stateCallback: @escaping ((ResponseStream<T>) -> Void)) -> URLSessionTask? {
        let urlRequest = self.requestFactory.request(url: request.url,
                                                           method: request.method,
                                                           headers: request.headers,
                                                           body: request.body)
        stateCallback(.loading)
        let sessionTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.isSuccess {
                if let data = data {
                    stateCallback(data.parse(with: request))
                } else {
                    stateCallback(.success(.empty))
                }
            } else if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.isClientError {
                stateCallback(ResponseStream.error(ApiError.client(httpResponse.statusCode)))
            } else if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.isServerError {
                stateCallback(ResponseStream.actionableError(ApiError.server(httpResponse.statusCode), request))
            } else if let error = error as NSError? {
                if (error.code == NSURLErrorNotConnectedToInternet ) {
                    stateCallback(.offline)
                } else {
                    stateCallback(ResponseStream.actionableError(ApiError.generic(error.code), request))
                }
            } else {
                stateCallback(ResponseStream.actionableError(ApiError.unknown, request))
            }
        }
        sessionTask.resume()
        return sessionTask
    }
}

private extension Data {
    func parse<T>(with request: Api.Request<T>) -> Api.ResponseStream<T> {
        guard let parser = request.parser else {
            return .error(.parserNotSet)
        }

        do {
            return .success(try parser(self, request))
        } catch {
            return .error(.parsingFailure(error))
        }
    }
}

private extension HTTPURLResponse {
    var isSuccess: Bool {
        return statusCode >= 200 && statusCode < 300
    }

    var isClientError: Bool {
        return statusCode >= 400 && statusCode < 500
    }

    var isServerError: Bool {
        return statusCode >= 500 && statusCode < 600
    }
}
