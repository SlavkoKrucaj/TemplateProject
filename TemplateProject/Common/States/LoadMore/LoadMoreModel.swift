import Foundation

import IGListKit

class LoadMoreModel<T>: NSObject, ListDiffable {
    let apiRequest: Api.Request<T>

    init(apiRequest: Api.Request<T>) {
        self.apiRequest = apiRequest
    }

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
