import Foundation

//sourcery: AutoMockable
protocol UrlRequestFactory {
    func request(url: URL,
                 method: String,
                 headers: [String: String],
                 body: Data?) -> URLRequest
}

class BasicUrlRequestFactory: UrlRequestFactory {
    func request(url: URL,
                 method: String,
                 headers: [String: String] = [:],
                 body: Data? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
