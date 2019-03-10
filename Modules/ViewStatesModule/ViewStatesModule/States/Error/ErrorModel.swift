import Foundation
import UIKit

import IGListKit

class ErrorModel: NSObject, ListDiffable {
    let image: String
    let message: String

    init(image: String, message: String) {
        self.image = image
        self.message = message
    }

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
