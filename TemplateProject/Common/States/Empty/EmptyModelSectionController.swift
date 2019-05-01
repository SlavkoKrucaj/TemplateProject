import Foundation
import UIKit

import IGListKit

final public class EmptyItemController: ListSectionController {
    static public func controller() -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            if let cell = cell as? EmptyViewCell,
                let item = item as? EmptyModel {
                cell.title = item.title
                cell.message = item.message
            }
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return context.insetContainerSize
        }

        return ListSingleSectionController(
            cellClass: EmptyViewCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}
