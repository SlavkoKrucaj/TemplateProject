import XCTest

@testable import TemplateProject

//swiftlint:disable cyclomatic_complexity

extension Api.ResponseStream: Equatable {
    public static func == (lhs: Api.ResponseStream<T>, rhs: Api.ResponseStream<T>) -> Bool {
        switch (lhs) {
        case .loading: if case .loading = rhs { return true } else { return false }
        case .error(let error):
            if case .error(let rError) = rhs { return areEqual(error, rError) } else { return false }
        case .actionableError(let error, let request):
            if case .actionableError(let rError, let rRequest) = rhs {
                return areEqual(error, rError) && areEqual(lhs: request, rhs: rRequest)
            } else {
                return false
            }
        case .offline: if case .offline = rhs { return true } else { return false }
        case .success: if case .success = rhs { return true } else { return false }
        }
    }

    private static func areEqual(_ lhs: Api.ApiError, _ rhs: Api.ApiError) -> Bool {
        switch (lhs) {
        case Api.ApiError.unknown:
            if case .unknown = rhs { return true } else { return false }
        case Api.ApiError.generic(let code):
            if case .generic(let rCode) = rhs { return code == rCode } else { return false }
        case Api.ApiError.client(let code):
            if case .client(let rCode) = rhs { return code == rCode } else { return false }
        case Api.ApiError.server(let code):
            if case .server(let rCode) = rhs { return code == rCode } else { return false }
        case Api.ApiError.parsingFailure(_):
            if case .parsingFailure(_) = rhs { return true } else { return false }
        case .parserNotSet:
            if case .parserNotSet = rhs { return true } else { return false }
        case .responseWithNoData:
            if case .responseWithNoData = rhs { return true } else { return false }
        }
    }

    public static func areEqual(lhs: Api.HTTPRequest<T>, rhs: Api.HTTPRequest<T>) -> Bool {
        return lhs.method == rhs.method &&
            lhs.url == rhs.url &&
            lhs.headers == rhs.headers &&
            lhs.body == rhs.body
    }

    public static func areEqual<T: Equatable>(lhs: Api.Result<T>, rhs: Api.Result<T>) -> Bool {
        switch (lhs) {
        case .empty:
            if case .empty = rhs { return true } else { return false }
        case .items(let items):
            if case .items(let lItems) = rhs { return items == lItems } else { return false }
        case .multiplePage(let items, _):
            if case .multiplePage(let lItems, _) = rhs { return items == lItems } else { return false }
        }
    }
}
