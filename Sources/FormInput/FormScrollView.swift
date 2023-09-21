//
//  FormScrollView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

class FormScrollView: UIScrollView {
    var stackView: FormStackView { contentView.stackView }
    var contentView: FormScrollContentView = FormScrollContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        insetsLayoutMarginsFromSafeArea = true
        addSubview(contentView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentSize = contentView.frame.size
    }
}
