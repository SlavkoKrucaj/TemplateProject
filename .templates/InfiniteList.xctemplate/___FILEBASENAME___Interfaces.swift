import Foundation
import UIKit

import RxSwift
import IGListKit

enum ___VARIABLE_moduleName___NavigationOption {
}

enum ___VARIABLE_moduleName___TrackingEvent {
    case viewed
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___TrackingInterface: class {
    func track(event: ___VARIABLE_moduleName___TrackingEvent)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___WireframeInterface: WireframeInterface {
    func navigate(to option: ___VARIABLE_moduleName___NavigationOption)
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___ViewInterface: class {
    func refreshView()
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___PresenterInterface: class {
    var items: [ListDiffable] { get }

    func load()
    func loadMore()
}

//sourcery: AutoMockable
protocol ___VARIABLE_moduleName___InteractorInterface: class {
    // TODO replace T with your type
    func load(_ request: Api.HTTPRequest<T>?) -> Observable<Api.Stream<T>>
}
