import Foundation
import UIKit

//sourcery: AutoMockable
public protocol StateProvider {
    func empty(title: String, message: String) -> EmptyModel
    func loading() -> LoadingModel
    func offline(image: UIImage, title: String, message: String) -> OfflineModel
    func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T>
    func error(image: UIImage, message: String) -> ErrorModel
}

struct BasicStateProvider: StateProvider {
    func empty(title: String, message: String) -> EmptyModel {
        return EmptyModel(title: title, message: message)
    }

    func loading() -> LoadingModel {
        return LoadingModel()
    }

    func offline(image: UIImage, title: String, message: String) -> OfflineModel {
        return OfflineModel(image: image,
                            title: title,
                            message: message)
    }

    func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T> {
        return LoadMoreModel(apiRequest: request)
    }

    func error(image: UIImage, message: String) -> ErrorModel {
        return ErrorModel(image: image,
                          message: message)
    }
}
