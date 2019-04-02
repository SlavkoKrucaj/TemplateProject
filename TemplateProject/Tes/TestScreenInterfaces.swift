import Foundation
import UIKit

import RxSwift
import IGListKit

enum TestScreenNavigationOption {
}

enum TestScreenTrackingEvent {
    case viewed
}

protocol TestScreenTrackingInterface: class {
    func track(event: TestScreenTrackingEvent)
}

protocol TestScreenWireframeInterface: WireframeInterface {
    func navigate(to option: TestScreenNavigationOption)
}

protocol TestScreenViewInterface: class {
    func refreshView()
}

protocol TestScreenPresenterInterface: class {
    var items: [ListDiffable] { get }

    func load()
    func loadMore()
}

protocol TestScreenInteractorInterface: class {
    func load(_ request: Api.HTTPRequest<Review>?) -> Observable<Api.State<Review>>
}
