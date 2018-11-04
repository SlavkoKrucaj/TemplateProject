import Foundation

public typealias JsonDictionary = [String: Any]

class Api {
    enum ApiError: Error {
        case unknown
        case generic(Int)
        case invalidRequest
    }

    enum State<T> {
        case loading
        case success(Response<T>)
        case error(Error, HTTPRequest<T>)
        case offline
    }

    enum Response<T> {
        case empty
        case items([T])
        case multiplePage([T], HTTPRequest<T>)
    }

    struct HTTPRequest<T> {
        let method: String
        let urlComponents: URLComponents
        let headers: [String: String]
        let body: Data?
        let parser: ((Data, HTTPRequest<T>) -> Response<T>)?

        static func get(components: URLComponents,
                        headers: [String: String] = [:],
                        parser: ((Data, HTTPRequest<T>) -> Response<T>)? = nil) -> HTTPRequest {
            return HTTPRequest(method: "GET", urlComponents: components, headers: headers, body: nil, parser: parser)
        }

        private init(method: String,
                     urlComponents: URLComponents,
                     headers: [String: String] = [:],
                     body: Data? = nil,
                     parser: ((Data, HTTPRequest<T>) -> Response<T>)? = nil) {
            self.method = method
            self.urlComponents = urlComponents
            self.headers = headers
            self.body = body
            self.parser = parser
        }
    }

    func load<T>(_ request: HTTPRequest<T>, stateCallback: @escaping ((State<T>) -> Void)) -> URLSessionTask? {
        guard let urlRequest = self.request(urlComponents: request.urlComponents,
                                            method: request.method,
                                            headers: request.headers,
                                            body: request.body) else {
            stateCallback(State.error(ApiError.invalidRequest, request))
            return nil
        }
        stateCallback(.loading)
        let sessionTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode >= 200,
                httpResponse.statusCode < 300,
                let data = data.flatMap({ data in request.parser?(data, request) }) {
                stateCallback(.success(data))
            } else if let error = error as NSError? {
                if (error.code == NSURLErrorNotConnectedToInternet ) {
                    stateCallback(.offline)
                } else {
                    stateCallback(State.error(ApiError.generic(error.code), request))
                }
            } else {
                stateCallback(State.error(ApiError.unknown, request))
            }
        }
        sessionTask.resume()
        return sessionTask
    }

    private func request(urlComponents: URLComponents,
                         method: String,
                         headers: [String: String] = [:],
                         body: Data? = nil) -> URLRequest? {
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
