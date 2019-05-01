import Foundation
import UIKit

import IGListKit

public protocol LoadMoreDelegate: class {
    func loadMore()
}

final public class LoadMoreItemController {
    static public func controller(delegate: LoadMoreDelegate) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            if let cell = cell as? LoadMoreSpinnerCell {
                cell.activityIndicator.startAnimating()
                delegate.loadMore()
            }
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.insetContainerSize.width, height: 60)
        }

        return ListSingleSectionController(
            cellClass: LoadMoreSpinnerCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}
