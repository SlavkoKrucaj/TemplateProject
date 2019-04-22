import XCTest

import Nimble
import RxSwift

final class NetworkRecorder<ElementType: Equatable>: ObserverType {
    public typealias Element = ElementType

    public let expectation = XCTestExpectation(description: "Network sent expected stream of events")
    private var eventQueue: [Event<ElementType>]

    init(expectedEvents: [Event<ElementType>]) {
        eventQueue = expectedEvents
    }

    public func on(_ event: Event<Element>) {
        expect(event).to(equal(self.dequeueEvent()))

        if (self.eventQueue.isEmpty) {
            self.expectation.fulfill()
        }
    }

    private func dequeueEvent() -> Event<ElementType> {
        let element = self.eventQueue.first!
        self.eventQueue.remove(at: 0)
        return element
    }
}
