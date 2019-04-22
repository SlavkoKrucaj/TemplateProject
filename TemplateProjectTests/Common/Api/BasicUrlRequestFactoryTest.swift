import XCTest

@testable import TemplateProject
import Quick
import Nimble

class BasicUrlRequestFactoryTest: QuickSpec {
    override func spec() {
        let subject = BasicUrlRequestFactory()

        let validUrl: URL = URL(string: "https://www.example.com")!
        let method: String = "GET"
        let headers: [String: String] = ["test": "testing"]
        let body: Data = "this is custom data for test".data(using: .utf8)!
        var request: URLRequest!

        beforeEach {
            request = subject.request(url: validUrl, method: method, headers: headers, body: body)
        }

        describe("request", {
            it("has correct url", closure: {
                expect(request.url?.absoluteString).to(equal(validUrl.absoluteString))
            })

            it("has correct method", closure: {
                expect(request.httpMethod).to(equal(method))
            })

            it("has correct http headers", closure: {
                expect(request.allHTTPHeaderFields).to(equal(headers))
            })

            it("has correct body", closure: {
                expect(request.httpBody).to(equal(body))
            })

        })
    }
}
