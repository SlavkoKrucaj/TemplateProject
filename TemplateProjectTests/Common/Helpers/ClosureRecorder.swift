import XCTest

import Nimble

final class ClosureRecorder<T: Equatable> {
    public let expectation: XCTestExpectation

    private let expectedValues: [T]
    private var currentValues: [T] = []

    init(values: [T]) {
        self.expectedValues = values
        self.currentValues = values
        self.expectation = XCTestExpectation(description: "all of the expected events in api stream have been delivered")
    }

    public func verify(_ value: T) {
        expect(value).to(equal(self.dequeue()))

        if (self.currentValues.isEmpty) {
            self.expectation.fulfill()
        }
    }

    private func dequeue() -> T {
        let element = self.currentValues.first!
        self.currentValues.remove(at: 0)
        return element
    }
}
