import XCTest

@testable import TemplateProject
import Quick
import Nimble

class ApiTest: QuickSpec {
    override func spec() {
        let subject: Api = Api()

        describe("load") {
            context("when request is valid", {

            })

            context("when request is not valid", {
                let invalidRequest: Api.HTTPRequest<String> = Api.HTTPRequest.get(components: URLComponents())

                it("should call state callback with correct error", closure: {
                    _ = subject.load(invalidRequest, stateCallback: { (stream) in
                        if case let .error(error, _) = stream {
                            expect(error).to(matchError(Api.ApiError.invalidRequest))
                        } else {
                            fail("Expected <error> but got <\(stream)>")
                        }
                    })
                })
            })
        }
    }
}
