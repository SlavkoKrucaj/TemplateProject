import Foundation

import IGListKit

class LoadMoreModel<T>: NSObject, ListDiffable {
    let apiRequest: Api.HTTPRequest<T>

    init(apiRequest: Api.HTTPRequest<T>) {
        self.apiRequest = apiRequest
    }

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
