// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//swiftlint:disable superfluous_disable_command
//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace

#if MockyCustom
import SwiftyMocky
import RxSwift
import RxBlocking
@testable import TemplateProject

    public final class MockyAssertion {
        public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
    }

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        guard let handler = MockyAssertion.handler else {
            assert(expression, message, file: file, line: line)
            return
        }

        handler(expression(), message(), file, line)
    }
#elseif Mocky
import SwiftyMocky
import XCTest
import RxSwift
import RxBlocking
@testable import TemplateProject

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        XCTAssert(expression(), message(), file: file, line: line)
    }
#else
import Sourcery
import SourceryRuntime
#endif


// MARK: - HttpLoader
open class HttpLoaderMock: HttpLoader, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func load<ResultType>(_ request: Api.HTTPRequest<ResultType>,                          stateCallback: @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> URLSessionTask? {
        addInvocation(.m_load__requeststateCallback_stateCallback(Parameter<Api.HTTPRequest<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_load__requeststateCallback_stateCallback(Parameter<Api.HTTPRequest<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric())) as? (Api.HTTPRequest<ResultType>, @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> Void
		perform?(`request`, `stateCallback`)
		var __value: URLSessionTask? = nil
		do {
		    __value = try methodReturnValue(.m_load__requeststateCallback_stateCallback(Parameter<Api.HTTPRequest<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func rx_load<T>(request: Api.HTTPRequest<T>) -> Observable<Api.ResponseStream<T >> {
        addInvocation(.m_rxload__request_request(Parameter<Api.HTTPRequest<T>>.value(`request`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_rxload__request_request(Parameter<Api.HTTPRequest<T>>.value(`request`).wrapAsGeneric())) as? (Api.HTTPRequest<T>) -> Void
		perform?(`request`)
		var __value: Observable<Api.ResponseStream<T >>
		do {
		    __value = try methodReturnValue(.m_rxload__request_request(Parameter<Api.HTTPRequest<T>>.value(`request`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for rx_load<T>(request: Api.HTTPRequest<T>). Use given")
			Failure("Stub return value not specified for rx_load<T>(request: Api.HTTPRequest<T>). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_load__requeststateCallback_stateCallback(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_rxload__request_request(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_load__requeststateCallback_stateCallback(let lhsRequest, let lhsStatecallback), .m_load__requeststateCallback_stateCallback(let rhsRequest, let rhsStatecallback)):
                guard Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsStatecallback, rhs: rhsStatecallback, with: matcher) else { return false } 
                return true 
            case (.m_rxload__request_request(let lhsRequest), .m_rxload__request_request(let rhsRequest)):
                guard Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_load__requeststateCallback_stateCallback(p0, p1): return p0.intValue + p1.intValue
            case let .m_rxload__request_request(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func load<ResultType>(_ request: Parameter<Api.HTTPRequest<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, willReturn: URLSessionTask?...) -> MethodStub {
            return Given(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func rx_load<T>(request: Parameter<Api.HTTPRequest<T>>, willReturn: Observable<Api.ResponseStream<T >>...) -> MethodStub {
            return Given(method: .m_rxload__request_request(`request`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func load<ResultType>(_ request: Parameter<Api.HTTPRequest<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, willProduce: (Stubber<URLSessionTask?>) -> Void) -> MethodStub {
            let willReturn: [URLSessionTask?] = []
			let given: Given = { return Given(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLSessionTask?).self)
			willProduce(stubber)
			return given
        }
        public static func rx_load<T>(request: Parameter<Api.HTTPRequest<T>>, willProduce: (Stubber<Observable<Api.ResponseStream<T >>>) -> Void) -> MethodStub {
            let willReturn: [Observable<Api.ResponseStream<T >>] = []
			let given: Given = { return Given(method: .m_rxload__request_request(`request`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<Api.ResponseStream<T >>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func load<ResultType>(_ request: Parameter<Api.HTTPRequest<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>) -> Verify { return Verify(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()))}
        public static func rx_load<T>(request: Parameter<Api.HTTPRequest<T>>) -> Verify { return Verify(method: .m_rxload__request_request(`request`.wrapAsGeneric()))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func load<ResultType>(_ request: Parameter<Api.HTTPRequest<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, perform: @escaping (Api.HTTPRequest<ResultType>, @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> Void) -> Perform {
            return Perform(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), performs: perform)
        }
        public static func rx_load<T>(request: Parameter<Api.HTTPRequest<T>>, perform: @escaping (Api.HTTPRequest<T>) -> Void) -> Perform {
            return Perform(method: .m_rxload__request_request(`request`.wrapAsGeneric()), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - UrlRequestFactory
open class UrlRequestFactoryMock: UrlRequestFactory, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func request(url: URL,                 method: String,                 headers: [String: String],                 body: Data?) -> URLRequest {
        addInvocation(.m_request__url_urlmethod_methodheaders_headersbody_body(Parameter<URL>.value(`url`), Parameter<String>.value(`method`), Parameter<[String: String]>.value(`headers`), Parameter<Data?>.value(`body`)))
		let perform = methodPerformValue(.m_request__url_urlmethod_methodheaders_headersbody_body(Parameter<URL>.value(`url`), Parameter<String>.value(`method`), Parameter<[String: String]>.value(`headers`), Parameter<Data?>.value(`body`))) as? (URL, String, [String: String], Data?) -> Void
		perform?(`url`, `method`, `headers`, `body`)
		var __value: URLRequest
		do {
		    __value = try methodReturnValue(.m_request__url_urlmethod_methodheaders_headersbody_body(Parameter<URL>.value(`url`), Parameter<String>.value(`method`), Parameter<[String: String]>.value(`headers`), Parameter<Data?>.value(`body`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for request(url: URL,                 method: String,                 headers: [String: String],                 body: Data?). Use given")
			Failure("Stub return value not specified for request(url: URL,                 method: String,                 headers: [String: String],                 body: Data?). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_request__url_urlmethod_methodheaders_headersbody_body(Parameter<URL>, Parameter<String>, Parameter<[String: String]>, Parameter<Data?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_request__url_urlmethod_methodheaders_headersbody_body(let lhsUrl, let lhsMethod, let lhsHeaders, let lhsBody), .m_request__url_urlmethod_methodheaders_headersbody_body(let rhsUrl, let rhsMethod, let rhsHeaders, let rhsBody)):
                guard Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMethod, rhs: rhsMethod, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsHeaders, rhs: rhsHeaders, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsBody, rhs: rhsBody, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_request__url_urlmethod_methodheaders_headersbody_body(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func request(url: Parameter<URL>, method: Parameter<String>, headers: Parameter<[String: String]>, body: Parameter<Data?>, willReturn: URLRequest...) -> MethodStub {
            return Given(method: .m_request__url_urlmethod_methodheaders_headersbody_body(`url`, `method`, `headers`, `body`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func request(url: Parameter<URL>, method: Parameter<String>, headers: Parameter<[String: String]>, body: Parameter<Data?>, willProduce: (Stubber<URLRequest>) -> Void) -> MethodStub {
            let willReturn: [URLRequest] = []
			let given: Given = { return Given(method: .m_request__url_urlmethod_methodheaders_headersbody_body(`url`, `method`, `headers`, `body`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLRequest).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func request(url: Parameter<URL>, method: Parameter<String>, headers: Parameter<[String: String]>, body: Parameter<Data?>) -> Verify { return Verify(method: .m_request__url_urlmethod_methodheaders_headersbody_body(`url`, `method`, `headers`, `body`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func request(url: Parameter<URL>, method: Parameter<String>, headers: Parameter<[String: String]>, body: Parameter<Data?>, perform: @escaping (URL, String, [String: String], Data?) -> Void) -> Perform {
            return Perform(method: .m_request__url_urlmethod_methodheaders_headersbody_body(`url`, `method`, `headers`, `body`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - WireframeInterface
open class WireframeInterfaceMock: WireframeInterface, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func dismiss(animated: Bool) {
        addInvocation(.m_dismiss__animated_animated(Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_dismiss__animated_animated(Parameter<Bool>.value(`animated`))) as? (Bool) -> Void
		perform?(`animated`)
    }


    fileprivate enum MethodType {
        case m_dismiss__animated_animated(Parameter<Bool>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_dismiss__animated_animated(let lhsAnimated), .m_dismiss__animated_animated(let rhsAnimated)):
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_dismiss__animated_animated(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func dismiss(animated: Parameter<Bool>) -> Verify { return Verify(method: .m_dismiss__animated_animated(`animated`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func dismiss(animated: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_dismiss__animated_animated(`animated`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

