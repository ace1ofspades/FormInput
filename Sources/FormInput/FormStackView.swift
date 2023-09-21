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
            spacing = flowLayout?.spacing() ?? 12
            arrangedSubviews.forEach({ removeArrangedSubview($0) })
            for (index, view) in formElements.enumerated() {
                let insets = flowLayout?.formView(formView, insetForRowAt: index)
                let height = flowLayout?.formView(formView, heightForRowAt: index) ?? view.getDefaultHeight()
                var constraints = ConstraintInset(left: insets?.left, right: insets?.right, height: height)
                addArrangedSubview(view, WithConstraints: constraints)
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
