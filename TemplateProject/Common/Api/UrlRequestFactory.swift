import Foundation

//sourcery: AutoMockable
public protocol UrlRequestFactory {
    func request(url: URL,
                 method: String,
                 headers: [String: String],
                 body: Data?) -> URLRequest
}

public final class BasicUrlRequestFactory: UrlRequestFactory {
    public func request(url: URL,
                        method: String,
                        headers: [String: String] = [:],
                        body: Data? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }

    public init() {
    }
}
