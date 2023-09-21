//
//  FormScrollContentView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

class FormScrollContentView: UIView {
    var stackView: FormStackView = FormStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(stackView, WithConstraints: ConstraintInset(top: 0, left: 0, right: 0))
        stackView.axis = .vertical
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size = CGSize(width: superview?.bounds.width ?? 0, height: stackView.height ?? 200)
    }
}

extension UIStackView {
    var height: CGFloat? {
        guard let last = arrangedSubviews.last else { return nil }
        return last.frame.origin.y + last.frame.height + spacing
    }

    var heightWithoutSpacing: CGFloat? {
        guard let last = arrangedSubviews.last else { return nil }
        return last.frame.origin.y + last.frame.height
    }
}
