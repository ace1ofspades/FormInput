//
//  FormStackView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import UIKit

// FormStackView sınıfı
class FormStackView: UIStackView {
    var formElements: [FormInputView] = [] {
        didSet {
            spacing = flowLayout?.spacing() ?? formView?.defaultSpacing ?? 12
            arrangedSubviews.forEach({ removeArrangedSubview($0) })
            for (index, view) in formElements.enumerated() {
                let insets = flowLayout?.formView(formView, insetForRowAt: index) ?? formView?.defaultInsets
                let height = flowLayout?.formView(formView, heightForRowAt: index) ?? view.getDefaultHeight()
                let constraints = ConstraintInset(left: insets?.left, right: insets?.right, height: height)
                addArrangedSubview(view, WithConstraints: constraints)
                if (index + 1 != formElements.count) {
                    //addArrangedSubview(SeparatorView(), WithConstraints: ConstraintInset(left: 16))
                }
            }
            layoutIfNeeded()
        }
    }

    var contentView: UIView? { superview }
    var scrollView: UIScrollView? { contentView?.superview as? UIScrollView }
    var formView: FormView? { scrollView?.superview as? FormView }

    var dataSource: FormViewDataSource? { formView?.dataSource }
    var flowLayout: FormViewDelegateFlowLayout? { formView?.flowLayout }
    var parentViewController: UIViewController? { formView?.parentViewController }

    func reloadData() {
        guard let dataSource = dataSource else {
            return
        }
        var tempFormElements: [FormInputView] = []
        for i in 0 ..< dataSource.numberOfInputs() {
            let view = dataSource.formView(formView, viewForRowAt: i)
            tempFormElements.append(view)
        }
        formElements = tempFormElements
    }
}

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // Customize the separator's appearance here
        backgroundColor = UIColor(white: 0.4, alpha: 0.2) // For example, a gray separator color
        heightAnchor.constraint(equalToConstant: 0.4).isActive = true // Adjust the height as needed
    }
}
