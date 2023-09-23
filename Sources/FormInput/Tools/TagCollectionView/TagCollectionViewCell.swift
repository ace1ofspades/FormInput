//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    //static var className: String! { String(describing: Self.self) }

    lazy var stackView: UIStackView = {
        let viewTag = 111
        guard let view = viewWithTag(viewTag) as? UIStackView else {
            let view = UIStackView()
            view.tag = viewTag
            view.contentMode = .scaleAspectFit
            view.alignment = .center
            view.isLayoutMarginsRelativeArrangement = true
            view.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            view.spacing = 2
            return view
        }
        return view
    }()

    lazy var iconImage: UIImageView = {
        let viewTag = 112
        guard let view = viewWithTag(viewTag) as? UIImageView else {
            let view = UIImageView()
            view.tag = viewTag
            view.contentMode = .scaleAspectFit
            return view
        }
        return view
    }()

    lazy var titleLabel: UILabel = {
        let viewTag = 113
        guard let view = viewWithTag(viewTag) as? UILabel else {
            let view = UILabel()
            view.tag = viewTag
            view.font = .systemFont(ofSize: 12, weight: .medium)
            return view
        }
        return view
    }()

    var text: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var image: UIImage? {
        get { iconImage.image }
        set { iconImage.image = newValue; iconImage.isHidden = newValue == nil }
    }

    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    var borderColor: CGColor? {
        get { layer.borderColor }
        set { layer.borderColor = newValue }
    }
    
    var iconSize:CGFloat = 18 {
        didSet {
            iconImage.heightConstraint?.constant = iconSize
            iconImage.widthConstraint?.constant = iconSize
        }
    }

    func commonInit() {
        addSubview(stackView)
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(titleLabel)

        borderWidth = 1
        borderColor = UIColor.systemGray5.cgColor
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 8
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: iconSize).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        //stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
