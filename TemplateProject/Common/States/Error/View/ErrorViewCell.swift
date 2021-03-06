import Foundation
import UIKit

final public class ErrorViewCell: UICollectionViewCell {
    private var inset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    public var action: (() -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = self.stackView

        let retryButton = self.retryButton
        let messageLabel = self.messageLabel

        retryButton.addTarget(self, action: #selector(retry(sender:)), for: .touchUpInside)

        stackView.addArrangedSubview(retryButton)
        stackView.addArrangedSubview(messageLabel)

        self.contentView.addSubview(stackView)

        messageLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
                                            multiplier: 1.0,
                                            constant: -inset.left - inset.right).isActive = true

        stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var retryButtonImage: UIImage? {
        get {
            return retryButton.image(for: .normal)
        }
        set {
            retryButton.setImage(newValue, for: .normal)
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

    private let retryButton: UIButton = {
        let retryButton = UIButton()
        retryButton.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
        retryButton.widthAnchor.constraint(equalToConstant: 42.0).isActive = true
        return retryButton
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
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

    @objc private func retry(sender: Any) {
        self.action?()
    }
}
