import Foundation
import UIKit

final public class LoadingSpinnerCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = self.stackView

        stackView.addArrangedSubview(activityIndicator)

        self.contentView.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stackView   = UIStackView()

        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        view.color = .gray
        self.contentView.addSubview(view)
        return view
    }()
}
