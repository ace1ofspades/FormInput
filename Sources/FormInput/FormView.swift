//
//  FormView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 19.09.2023.
//

import UIKit

// FormView sınıfı
public class FormView: UIView {
    
    public var formElements: [FormInputView] {
        get {
            stackView.formElements
        }
        set {
            stackView.formElements = newValue
        }
    }
    
    var scrollView: FormScrollView = FormScrollView()
    var contentView: FormScrollContentView { scrollView.contentView }
    var stackView: FormStackView { contentView.stackView }

    public var parentViewController: UIViewController?
    public var dataSource: FormViewDataSource?
    public var flowLayout: FormViewDelegateFlowLayout?

    public var formJson: [String: Any] {
        var newDictionary: [String: Any] = [:]
        for i in stackView.formElements {
            if let name = i.name {
                newDictionary[name] = i.value
            }
        }
        return newDictionary
    }

    public func reloadData() {
        stackView.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(scrollView, WithConstraints: .zero)
    }
}












extension UIView {
    convenience init(Tag tag: Int) {
        self.init()
        self.tag = tag
    }

    func addSubview(_ view: UIView, WithConstraints insets: ConstraintInset) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if let value = insets.top {
            view.topAnchor.constraint(equalTo: topAnchor, constant: value).isActive = true
        }

        if let value = insets.left {
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: value).isActive = true
        }

        if let value = insets.bottom {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: value).isActive = true
        }

        if let value = insets.right {
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: value).isActive = true
        }
    }
}

extension UIStackView {
    func addArrangedSubview(_ view: UIView, WithConstraints insets: ConstraintInset) {
        addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if let value = insets.top {
            view.topAnchor.constraint(equalTo: topAnchor, constant: value).isActive = true
        }

        if let value = insets.left {
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: value).isActive = true
        }

        if let value = insets.bottom {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: value).isActive = true
        }

        if let value = insets.right {
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: value).isActive = true
        }
    }
}
