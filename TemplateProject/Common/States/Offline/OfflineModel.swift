import Foundation
import IGListKit
import UIKit

final public class OfflineModel: NSObject, ListDiffable {
    let image: String
    let title: String
    let message: String

    public init(image: String, title: String, message: String) {
        self.image = image
        self.title = title
        self.message = message
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
