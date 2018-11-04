import Foundation

public typealias JsonDictionary = [String: Any]

public final class Api {
    enum ApiError: Error {
        case unknown
        case generic(Int)
        case invalidRequest
        case parsingFailure(String)
    }

    enum Stream<T> {
        case loading
        case success(Result<T>)
        case error(Error, HTTPRequest<T>)
        case offline
    }

    enum Result<T> {
        case empty
        case items([T])
        case multiplePage([T], HTTPRequest<T>)
    }

    struct HTTPRequest<T> {
        let method: String
        let urlComponents: URLComponents
        let headers: [String: String]
        let body: Data?
        let parser: ((Data, HTTPRequest<T>) throws -> Result<T>)?

        static func get(components: URLComponents,
                        headers: [String: String] = [:],
                        parser: ((Data, HTTPRequest<T>) -> Result<T>)? = nil) -> HTTPRequest {
            return HTTPRequest(method: "GET", urlComponents: components, headers: headers, body: nil, parser: parser)
        }

        private init(method: String,
                     urlComponents: URLComponents,
                     headers: [String: String] = [:],
                     body: Data? = nil,
                     parser: ((Data, HTTPRequest<T>) -> Result<T>)? = nil) {
            self.method = method
            self.urlComponents = urlComponents
            self.headers = headers
            self.body = body
            self.parser = parser
        }
    }

    func load<T>(_ request: HTTPRequest<T>, stateCallback: @escaping ((Stream<T>) -> Void)) -> URLSessionTask? {
        guard let urlRequest = self.request(urlComponents: request.urlComponents,
                                            method: request.method,
                                            headers: request.headers,
                                            body: request.body) else {
            stateCallback(Stream.error(ApiError.invalidRequest, request))
            return nil
        }
        stateCallback(.loading)
        //swiftlint:disable force_try
        let sessionTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode >= 200,
                httpResponse.statusCode < 300,
                let data = data.flatMap({ data in try! request.parser?(data, request) }) {
                stateCallback(.success(data))
            } else if let error = error as NSError? {
                if (error.code == NSURLErrorNotConnectedToInternet ) {
                    stateCallback(.offline)
                } else {
                    stateCallback(Stream.error(ApiError.generic(error.code), request))
                }
            } else {
                stateCallback(Stream.error(ApiError.unknown, request))
            }
        }
        //swiftlint:enable force_try
        sessionTask.resume()
        return sessionTask
    }

    private func request(urlComponents: URLComponents,
                         method: String,
                         headers: [String: String] = [:],
                         body: Data? = nil) -> URLRequest? {
        guard let url = urlComponents.url, !url.absoluteString.isEmpty else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
