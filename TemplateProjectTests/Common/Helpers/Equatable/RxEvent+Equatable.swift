import Foundation
import RxSwift

extension Event: Equatable where Element: Equatable {
    public static func == (lhs: Event<Element>, rhs: Event<Element>) -> Bool {
        switch (lhs, rhs) {
        case (.next(let lElem), .next(let rElem)): return lElem == rElem
        case (.completed, .completed): return true
        case (.error, .error): return true
        default: return false
        }
    }
}
