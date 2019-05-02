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


// MARK: - AnalyticsProviderInterface
open class AnalyticsProviderInterfaceMock: AnalyticsProviderInterface, Mock {
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





    open func log(event: String, parameters: [String: Any]?) {
        addInvocation(.m_log__event_eventparameters_parameters(Parameter<String>.value(`event`), Parameter<[String: Any]?>.value(`parameters`)))
		let perform = methodPerformValue(.m_log__event_eventparameters_parameters(Parameter<String>.value(`event`), Parameter<[String: Any]?>.value(`parameters`))) as? (String, [String: Any]?) -> Void
		perform?(`event`, `parameters`)
    }


    fileprivate enum MethodType {
        case m_log__event_eventparameters_parameters(Parameter<String>, Parameter<[String: Any]?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_log__event_eventparameters_parameters(let lhsEvent, let lhsParameters), .m_log__event_eventparameters_parameters(let rhsEvent, let rhsParameters)):
                guard Parameter.compare(lhs: lhsEvent, rhs: rhsEvent, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsParameters, rhs: rhsParameters, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_log__event_eventparameters_parameters(p0, p1): return p0.intValue + p1.intValue
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

        public static func log(event: Parameter<String>, parameters: Parameter<[String: Any]?>) -> Verify { return Verify(method: .m_log__event_eventparameters_parameters(`event`, `parameters`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func log(event: Parameter<String>, parameters: Parameter<[String: Any]?>, perform: @escaping (String, [String: Any]?) -> Void) -> Perform {
            return Perform(method: .m_log__event_eventparameters_parameters(`event`, `parameters`), performs: perform)
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

    public var rx: RxSwift.Reactive<HttpLoader> {
		get {	invocations.append(.p_rx_get); return __p_rx ?? givenGetterValue(.p_rx_get, "HttpLoaderMock - stub value for rx was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_rx = newValue }
	}
	private var __p_rx: (RxSwift.Reactive<HttpLoader>)?





    open func load<ResultType>(_ request: Api.Request<ResultType>,                          stateCallback: @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> URLSessionTask? {
        addInvocation(.m_load__requeststateCallback_stateCallback(Parameter<Api.Request<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_load__requeststateCallback_stateCallback(Parameter<Api.Request<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric())) as? (Api.Request<ResultType>, @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> Void
		perform?(`request`, `stateCallback`)
		var __value: URLSessionTask? = nil
		do {
		    __value = try methodReturnValue(.m_load__requeststateCallback_stateCallback(Parameter<Api.Request<ResultType>>.value(`request`).wrapAsGeneric(), Parameter<(Api.ResponseStream<ResultType>) -> Void>.value(`stateCallback`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_load__requeststateCallback_stateCallback(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case p_rx_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_load__requeststateCallback_stateCallback(let lhsRequest, let lhsStatecallback), .m_load__requeststateCallback_stateCallback(let rhsRequest, let rhsStatecallback)):
                guard Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsStatecallback, rhs: rhsStatecallback, with: matcher) else { return false } 
                return true 
            case (.p_rx_get,.p_rx_get): return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_load__requeststateCallback_stateCallback(p0, p1): return p0.intValue + p1.intValue
            case .p_rx_get: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func rx(getter defaultValue: RxSwift.Reactive<HttpLoader>...) -> PropertyStub {
            return Given(method: .p_rx_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func load<ResultType>(_ request: Parameter<Api.Request<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, willReturn: URLSessionTask?...) -> MethodStub {
            return Given(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func load<ResultType>(_ request: Parameter<Api.Request<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, willProduce: (Stubber<URLSessionTask?>) -> Void) -> MethodStub {
            let willReturn: [URLSessionTask?] = []
			let given: Given = { return Given(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLSessionTask?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func load<ResultType>(_ request: Parameter<Api.Request<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>) -> Verify { return Verify(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()))}
        public static var rx: Verify { return Verify(method: .p_rx_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func load<ResultType>(_ request: Parameter<Api.Request<ResultType>>, stateCallback: Parameter<(Api.ResponseStream<ResultType>) -> Void>, perform: @escaping (Api.Request<ResultType>, @escaping ((Api.ResponseStream<ResultType>) -> Void)) -> Void) -> Perform {
            return Perform(method: .m_load__requeststateCallback_stateCallback(`request`.wrapAsGeneric(), `stateCallback`.wrapAsGeneric()), performs: perform)
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

// MARK: - StateProviderInterface
open class StateProviderInterfaceMock: StateProviderInterface, Mock {
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





    open func empty(title: String, message: String) -> EmptyModel {
        addInvocation(.m_empty__title_titlemessage_message(Parameter<String>.value(`title`), Parameter<String>.value(`message`)))
		let perform = methodPerformValue(.m_empty__title_titlemessage_message(Parameter<String>.value(`title`), Parameter<String>.value(`message`))) as? (String, String) -> Void
		perform?(`title`, `message`)
		var __value: EmptyModel
		do {
		    __value = try methodReturnValue(.m_empty__title_titlemessage_message(Parameter<String>.value(`title`), Parameter<String>.value(`message`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for empty(title: String, message: String). Use given")
			Failure("Stub return value not specified for empty(title: String, message: String). Use given")
		}
		return __value
    }

    open func loading() -> LoadingModel {
        addInvocation(.m_loading)
		let perform = methodPerformValue(.m_loading) as? () -> Void
		perform?()
		var __value: LoadingModel
		do {
		    __value = try methodReturnValue(.m_loading).casted()
		} catch {
			onFatalFailure("Stub return value not specified for loading(). Use given")
			Failure("Stub return value not specified for loading(). Use given")
		}
		return __value
    }

    open func offline(image: UIImage, title: String, message: String) -> OfflineModel {
        addInvocation(.m_offline__image_imagetitle_titlemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`title`), Parameter<String>.value(`message`)))
		let perform = methodPerformValue(.m_offline__image_imagetitle_titlemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`title`), Parameter<String>.value(`message`))) as? (UIImage, String, String) -> Void
		perform?(`image`, `title`, `message`)
		var __value: OfflineModel
		do {
		    __value = try methodReturnValue(.m_offline__image_imagetitle_titlemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`title`), Parameter<String>.value(`message`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for offline(image: UIImage, title: String, message: String). Use given")
			Failure("Stub return value not specified for offline(image: UIImage, title: String, message: String). Use given")
		}
		return __value
    }

    open func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T> {
        addInvocation(.m_loadMore__request_request(Parameter<Api.Request<T>>.value(`request`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_loadMore__request_request(Parameter<Api.Request<T>>.value(`request`).wrapAsGeneric())) as? (Api.Request<T>) -> Void
		perform?(`request`)
		var __value: LoadMoreModel<T>
		do {
		    __value = try methodReturnValue(.m_loadMore__request_request(Parameter<Api.Request<T>>.value(`request`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for loadMore<T>(request: Api.Request<T>). Use given")
			Failure("Stub return value not specified for loadMore<T>(request: Api.Request<T>). Use given")
		}
		return __value
    }

    open func error(image: UIImage, message: String) -> ErrorModel {
        addInvocation(.m_error__image_imagemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`message`)))
		let perform = methodPerformValue(.m_error__image_imagemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`message`))) as? (UIImage, String) -> Void
		perform?(`image`, `message`)
		var __value: ErrorModel
		do {
		    __value = try methodReturnValue(.m_error__image_imagemessage_message(Parameter<UIImage>.value(`image`), Parameter<String>.value(`message`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for error(image: UIImage, message: String). Use given")
			Failure("Stub return value not specified for error(image: UIImage, message: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_empty__title_titlemessage_message(Parameter<String>, Parameter<String>)
        case m_loading
        case m_offline__image_imagetitle_titlemessage_message(Parameter<UIImage>, Parameter<String>, Parameter<String>)
        case m_loadMore__request_request(Parameter<GenericAttribute>)
        case m_error__image_imagemessage_message(Parameter<UIImage>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_empty__title_titlemessage_message(let lhsTitle, let lhsMessage), .m_empty__title_titlemessage_message(let rhsTitle, let rhsMessage)):
                guard Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher) else { return false } 
                return true 
            case (.m_loading, .m_loading):
                return true 
            case (.m_offline__image_imagetitle_titlemessage_message(let lhsImage, let lhsTitle, let lhsMessage), .m_offline__image_imagetitle_titlemessage_message(let rhsImage, let rhsTitle, let rhsMessage)):
                guard Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher) else { return false } 
                return true 
            case (.m_loadMore__request_request(let lhsRequest), .m_loadMore__request_request(let rhsRequest)):
                guard Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher) else { return false } 
                return true 
            case (.m_error__image_imagemessage_message(let lhsImage, let lhsMessage), .m_error__image_imagemessage_message(let rhsImage, let rhsMessage)):
                guard Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_empty__title_titlemessage_message(p0, p1): return p0.intValue + p1.intValue
            case .m_loading: return 0
            case let .m_offline__image_imagetitle_titlemessage_message(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_loadMore__request_request(p0): return p0.intValue
            case let .m_error__image_imagemessage_message(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func empty(title: Parameter<String>, message: Parameter<String>, willReturn: EmptyModel...) -> MethodStub {
            return Given(method: .m_empty__title_titlemessage_message(`title`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func loading(willReturn: LoadingModel...) -> MethodStub {
            return Given(method: .m_loading, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func offline(image: Parameter<UIImage>, title: Parameter<String>, message: Parameter<String>, willReturn: OfflineModel...) -> MethodStub {
            return Given(method: .m_offline__image_imagetitle_titlemessage_message(`image`, `title`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func loadMore<T>(request: Parameter<Api.Request<T>>, willReturn: LoadMoreModel<T>...) -> MethodStub {
            return Given(method: .m_loadMore__request_request(`request`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func error(image: Parameter<UIImage>, message: Parameter<String>, willReturn: ErrorModel...) -> MethodStub {
            return Given(method: .m_error__image_imagemessage_message(`image`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func empty(title: Parameter<String>, message: Parameter<String>, willProduce: (Stubber<EmptyModel>) -> Void) -> MethodStub {
            let willReturn: [EmptyModel] = []
			let given: Given = { return Given(method: .m_empty__title_titlemessage_message(`title`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (EmptyModel).self)
			willProduce(stubber)
			return given
        }
        public static func loading(willProduce: (Stubber<LoadingModel>) -> Void) -> MethodStub {
            let willReturn: [LoadingModel] = []
			let given: Given = { return Given(method: .m_loading, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (LoadingModel).self)
			willProduce(stubber)
			return given
        }
        public static func offline(image: Parameter<UIImage>, title: Parameter<String>, message: Parameter<String>, willProduce: (Stubber<OfflineModel>) -> Void) -> MethodStub {
            let willReturn: [OfflineModel] = []
			let given: Given = { return Given(method: .m_offline__image_imagetitle_titlemessage_message(`image`, `title`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (OfflineModel).self)
			willProduce(stubber)
			return given
        }
        public static func loadMore<T>(request: Parameter<Api.Request<T>>, willProduce: (Stubber<LoadMoreModel<T>>) -> Void) -> MethodStub {
            let willReturn: [LoadMoreModel<T>] = []
			let given: Given = { return Given(method: .m_loadMore__request_request(`request`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (LoadMoreModel<T>).self)
			willProduce(stubber)
			return given
        }
        public static func error(image: Parameter<UIImage>, message: Parameter<String>, willProduce: (Stubber<ErrorModel>) -> Void) -> MethodStub {
            let willReturn: [ErrorModel] = []
			let given: Given = { return Given(method: .m_error__image_imagemessage_message(`image`, `message`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ErrorModel).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func empty(title: Parameter<String>, message: Parameter<String>) -> Verify { return Verify(method: .m_empty__title_titlemessage_message(`title`, `message`))}
        public static func loading() -> Verify { return Verify(method: .m_loading)}
        public static func offline(image: Parameter<UIImage>, title: Parameter<String>, message: Parameter<String>) -> Verify { return Verify(method: .m_offline__image_imagetitle_titlemessage_message(`image`, `title`, `message`))}
        public static func loadMore<T>(request: Parameter<Api.Request<T>>) -> Verify { return Verify(method: .m_loadMore__request_request(`request`.wrapAsGeneric()))}
        public static func error(image: Parameter<UIImage>, message: Parameter<String>) -> Verify { return Verify(method: .m_error__image_imagemessage_message(`image`, `message`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func empty(title: Parameter<String>, message: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_empty__title_titlemessage_message(`title`, `message`), performs: perform)
        }
        public static func loading(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_loading, performs: perform)
        }
        public static func offline(image: Parameter<UIImage>, title: Parameter<String>, message: Parameter<String>, perform: @escaping (UIImage, String, String) -> Void) -> Perform {
            return Perform(method: .m_offline__image_imagetitle_titlemessage_message(`image`, `title`, `message`), performs: perform)
        }
        public static func loadMore<T>(request: Parameter<Api.Request<T>>, perform: @escaping (Api.Request<T>) -> Void) -> Perform {
            return Perform(method: .m_loadMore__request_request(`request`.wrapAsGeneric()), performs: perform)
        }
        public static func error(image: Parameter<UIImage>, message: Parameter<String>, perform: @escaping (UIImage, String) -> Void) -> Perform {
            return Perform(method: .m_error__image_imagemessage_message(`image`, `message`), performs: perform)
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

// MARK: - TranslatorInterface
open class TranslatorInterfaceMock: TranslatorInterface, Mock {
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





    open func translate(_ string: String) -> String {
        addInvocation(.m_translate__string(Parameter<String>.value(`string`)))
		let perform = methodPerformValue(.m_translate__string(Parameter<String>.value(`string`))) as? (String) -> Void
		perform?(`string`)
		var __value: String
		do {
		    __value = try methodReturnValue(.m_translate__string(Parameter<String>.value(`string`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for translate(_ string: String). Use given")
			Failure("Stub return value not specified for translate(_ string: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_translate__string(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_translate__string(let lhsString), .m_translate__string(let rhsString)):
                guard Parameter.compare(lhs: lhsString, rhs: rhsString, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_translate__string(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func translate(_ string: Parameter<String>, willReturn: String...) -> MethodStub {
            return Given(method: .m_translate__string(`string`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func translate(_ string: Parameter<String>, willProduce: (Stubber<String>) -> Void) -> MethodStub {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .m_translate__string(`string`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func translate(_ string: Parameter<String>) -> Verify { return Verify(method: .m_translate__string(`string`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func translate(_ string: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_translate__string(`string`), performs: perform)
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

