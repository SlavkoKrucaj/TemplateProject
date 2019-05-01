import Foundation
import UIKit

import IGListKit

final public class ErrorModel: NSObject, ListDiffable {
    let image: String
    let message: String

    init(image: String, message: String) {
        self.image = image
        self.message = message
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
