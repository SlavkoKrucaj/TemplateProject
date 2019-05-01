import Foundation

//sourcery: AutoMockable
public protocol StateProvider {
    func empty(title: String, message: String) -> EmptyModel
    func loading() -> LoadingModel
    func offline(imageName: String, title: String, message: String) -> OfflineModel
    func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T>
    func error(imageName: String, message: String) -> ErrorModel
}

struct BasicStateProvider: StateProvider {
    func empty(title: String, message: String) -> EmptyModel {
        return EmptyModel(title: title, message: message)
    }

    func loading() -> LoadingModel {
        return LoadingModel()
    }

    func offline(imageName: String, title: String, message: String) -> OfflineModel {
        return OfflineModel(image: imageName,
                            title: title,
                            message: message)
    }

    func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T> {
        return LoadMoreModel(apiRequest: request)
    }

    func error(imageName: String, message: String) -> ErrorModel {
        return ErrorModel(image: imageName,
                          message: message)
    }
}
