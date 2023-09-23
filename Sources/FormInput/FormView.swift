//
//  FormView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 19.09.2023.
//

import UIKit

// FormView sınıfı
public class FormView: UIView {
    public var formElements: [FormInputView?] {
        get {
            stackView.formElements
        }
        set {
            stackView.formElements = newValue.compactMap({ $0 })
        }
    }

    var scrollView: FormScrollView = FormScrollView()
    var contentView: FormScrollContentView { scrollView.contentView }
    var stackView: FormStackView { contentView.stackView }

    public var parentViewController: UIViewController?
    public var dataSource: FormViewDataSource?
    public var flowLayout: FormViewDelegateFlowLayout?

    public var defaultSpacing: CGFloat = 20
    public var defaultInsets: UIEdgeInsets = .zero

    public var isValidate: Bool {
        for i in stackView.formElements {
            if i.validationRule(i.value, i.isRequired) {
                continue
            }
            i.showValidation()
            return false
        }
        return true
    }

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

    public var onSubmit: ((_ jsonValue: [String: Any]) -> Void)?
    public var url: String?
    public var method: String = "POST"
    public var headers: [String: String]?

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

        // Klavye gösterme olayını gözlemleyin
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Klavye gizleme olayını gözlemleyin
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if
               let firstResponder = findFirstResponder() {
                let firstResponderFrameInRootView = firstResponder.convert(firstResponder.bounds, to: self)
                let viewOffsetY = (firstResponderFrameInRootView.origin.y + firstResponderFrameInRootView.height)
                let scrollOffsetY = scrollView.contentOffset.y
                if viewOffsetY > keyboardSize.origin.y {
                    let offsetY = scrollOffsetY + (viewOffsetY - keyboardSize.origin.y)
                    scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
                }
            }
            scrollView.bottomConstraint?.constant = -keyboardSize.height
            addKeyboardDismissGesture()
            layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.bottomConstraint?.constant = 0
        removeKeyboardDismissGesture()
        layoutIfNeeded()
    }

    deinit {
        // ViewController sona erdiğinde NotificationCenter gözlemcilerini kaldırın
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIView {
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    func addKeyboardDismissGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    func removeKeyboardDismissGesture() {
        for gestureRecognizer in gestureRecognizers ?? [] {
            if gestureRecognizer is UITapGestureRecognizer {
                removeGestureRecognizer(gestureRecognizer)
            }
        }
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}

public extension FormView {
    func submit(_ handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void = { _, _, _ in }) {
        if let onSubmit = onSubmit {
            onSubmit(formJson)
        } else if let urlString = url, let url = URL(string: urlString) {
            let session = URLSession.shared
            var request = URLRequest(url: url)

            request.allHTTPHeaderFields = headers
            if let data = try? JSONSerialization.data(withJSONObject: formJson) {
                request.httpBody = data
            }
            request.httpMethod = method
            let task = session.dataTask(with: request, completionHandler: handler)
            task.resume()
        }
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

    func addSubview(_ view: UIView, WithSafeConstraints insets: ConstraintInset) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        if let value = insets.top {
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: value).isActive = true
        }

        if let value = insets.left {
            view.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: value).isActive = true
        }

        if let value = insets.bottom {
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: value).isActive = true
        }

        if let value = insets.right {
            view.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: value).isActive = true
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

        if let value = insets.height {
            view.heightAnchor.constraint(equalToConstant: value).isActive = true
        }
    }
}
