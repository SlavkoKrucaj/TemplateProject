import Foundation
import UIKit

import IGListKit

final class LoadingItemController {
    static func controller(height: CGFloat? = nil) -> ListSingleSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            if let cell = cell as? LoadingSpinnerCell {
                cell.activityIndicator.startAnimating()
            }
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let height = height else {
                return context!.insetContainerSize

            }
            return CGSize(width: context!.containerSize.width, height: height)
        }

        return ListSingleSectionController(
            cellClass: LoadingSpinnerCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}
