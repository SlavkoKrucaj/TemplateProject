import Foundation
import UIKit

import IGListKit

protocol ErrorDelegate: class {
    func reload()
}

final class ErrorItemController: ListSectionController {
    static func controller(delegate: ErrorDelegate) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            if let cell = cell as? ErrorViewCell,
                let item = item as? ErrorModel {
                cell.message = item.message
                cell.retryButtonImage = UIImage(named: item.image)
                cell.action = { delegate.reload() }
            }
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return context.insetContainerSize
        }

        return ListSingleSectionController(
            cellClass: ErrorViewCell.self,
            configureBlock: configureBlock,
            sizeBlock: sizeBlock)
    }
}
