import Foundation
import IGListKit
import UIKit

final public class OfflineModel: NSObject, ListDiffable {
    let image: UIImage
    let title: String
    let message: String

    public init(image: UIImage, title: String, message: String) {
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
