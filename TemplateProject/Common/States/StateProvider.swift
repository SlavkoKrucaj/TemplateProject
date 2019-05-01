import Foundation

class StateProvider {
    private let title: String
    private let message: String
    private let loadingMessage: String?

    init(title: String? = nil,
         message: String? = nil,
         loadingMessage: String? = nil) {
        self.title = title ?? "no_content_title".localized()
        self.message = message ?? "no_content_message".localized()
        self.loadingMessage = loadingMessage
    }

    func empty() -> EmptyModel {
        return EmptyModel(title: self.title, message: self.message)
    }

    func loading() -> LoadingModel {
        return LoadingModel()
    }

    func offline() -> OfflineModel {
        return OfflineModel(image: "offline_icon",
                            title: "default_offline_title".localized(),
                            message: "default_offline_message".localized())
    }

    func loadMore<T>(request: Api.Request<T>) -> LoadMoreModel<T> {
        return LoadMoreModel(apiRequest: request)
    }

    func error() -> ErrorModel {
        return ErrorModel(image: "warning",
                          message: "default_error_message".localized())
    }
}
