import Foundation

class CollectionParser<T> {
    private let itemParser: (JsonDictionary) -> T?

    init(itemParser: @escaping (JsonDictionary) -> T?) {
        self.itemParser = itemParser
    }

    func parse(data: Data, request: Api.HTTPRequest<T>) -> Api.Response<T> {
        return Api.Response.empty
    }
}
