import Foundation

import IGListKit

final public class LoadMoreModel<T>: NSObject, ListDiffable {
    let apiRequest: Api.Request<T>

    init(apiRequest: Api.Request<T>) {
        self.apiRequest = apiRequest
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
