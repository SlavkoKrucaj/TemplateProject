import Foundation
import IGListKit
import UIKit

class OfflineModel: NSObject, ListDiffable {
    let image: String
    let title: String
    let message: String

    init(image: String, title: String, message: String) {
        self.image = image
        self.title = title
        self.message = message
    }

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
