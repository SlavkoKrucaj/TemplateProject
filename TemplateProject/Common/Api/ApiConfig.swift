import Foundation

class ApiConfigProvider {
    static var `default`: ApiConfig {
        return ProductionApiConfig()
    }
}

protocol ApiConfig {
    var pageSize: String { get }
    var host: String { get }
    var scheme: String { get }
    var baseUrlComponents: URLComponents { get }
    var headers: [String: String] { get }
}

struct ProductionApiConfig: ApiConfig {
    var pageSize: String {
        return "50"
    }

    var host: String {
        return "www.enter_your_domain.com"
    }

    var scheme: String {
        return "https"
    }

    var baseUrlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        return urlComponents
    }

    var headers: [String: String] {
        return [
            "Accept": "application/json"
        ]
    }
}
