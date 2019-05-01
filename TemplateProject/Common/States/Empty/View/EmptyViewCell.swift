import Foundation
import UIKit

public final class EmptyViewCell: UICollectionViewCell {
    private var inset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = self.stackView

        let imageView = self.imageView
        let titleLabel = self.titleLabel
        let messageLabel = self.messageLabel

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)

        self.contentView.addSubview(stackView)

        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
                                          multiplier: 1.0,
                                          constant: -inset.left - inset.right).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
                                            multiplier: 1.0,
                                            constant: -inset.left - inset.right).isActive = true

        stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public var message: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 42.0).isActive = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0

        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView   = UIStackView()

        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
}
