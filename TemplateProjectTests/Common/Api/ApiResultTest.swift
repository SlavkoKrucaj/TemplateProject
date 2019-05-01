import Quick
import Nimble

@testable import TemplateProject

final class ApiResultTest: QuickSpec {
    override func spec() {
        describe("unwrap") {
            context("when empty", {
                it("should return empty array", closure: {
                    expect(Api.Result<String>.empty.unwrap()).to(equal([]))
                })
            })

            context("when items", {
                let items = ["Test 1", "Test 2"]

                it("should return list of items", closure: {
                    expect(Api.Result.items(items).unwrap()).to(equal(items))
                })
            })

            context("when multiple page", {
                let items = ["Test 1", "Test 2"]
                let request = Api.Request<String>.get(url: URL(string: "www.google.com")!)

                it("should return list of items", closure: {
                    expect(Api.Result.multiplePage(items, request).unwrap()).to(equal(items))
                })
            })
        }
    }
}
