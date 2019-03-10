import Foundation
import UIKit

import IGListKit

final class OfflineItemController {
    static func controller() -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            if let cell = cell as? OfflineViewCell,
                let item = item as? OfflineModel {
                cell.image = UIImage(named: item.image)
                cell.title = item.title
                cell.message = item.message
            }
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return context.insetContainerSize
        }

        return ListSingleSectionController(
            cellClass: OfflineViewCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}