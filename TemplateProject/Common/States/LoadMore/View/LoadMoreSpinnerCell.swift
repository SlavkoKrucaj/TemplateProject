import Foundation
import UIKit

final class LoadMoreSpinnerCell: UICollectionViewCell {
    var color: UIColor = .gray

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        view.color = .gray
        self.contentView.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
