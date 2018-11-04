import Foundation
import UIKit

import RxSwift
import IGListKit

enum ___VARIABLE_moduleName___NavigationOption {
}

enum ___VARIABLE_moduleName___TrackingEvent {
    case viewed
}

protocol ___VARIABLE_moduleName___TrackingInterface: class {
    func track(event: ___VARIABLE_moduleName___TrackingEvent)
}

protocol ___VARIABLE_moduleName___WireframeInterface: WireframeInterface {
    func navigate(to option: ___VARIABLE_moduleName___NavigationOption)
}

protocol ___VARIABLE_moduleName___ViewInterface: class {
    func refreshView()
}

protocol ___VARIABLE_moduleName___PresenterInterface: class {
    var items: [ListDiffable] { get }

    func load()
    func loadMore()
}

protocol ___VARIABLE_moduleName___InteractorInterface: class {
    func load(_ request: Api.HTTPRequest<Review>?) -> Observable<Api.State<Review>>
}
