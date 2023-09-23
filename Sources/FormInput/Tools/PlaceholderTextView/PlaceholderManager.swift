//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit


class PlaceholderManager: NSObject {
    private weak var textView: UITextView?
    private var placeholderLabel: UILabel?

    var maxCharacterCount: Int?

    var placeholder: String? {
        get {
            return placeholderLabel?.text
        }
        set {
            placeholderLabel?.text = newValue
            textView?.setNeedsLayout()
        }
    }

    init(textView: UITextView) {
        super.init()
        self.textView = textView
        setupObservers()
        createPlaceholderLabel()
    }

    deinit {
        removeObservers()
    }

    func updateConstraints() {
        guard let textView = textView, let placeholderLabel = placeholderLabel else {
            return
        }

        NSLayoutConstraint.deactivate(textView.constraints.filter { $0.firstItem === placeholderLabel })

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: textView.textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: textView.textContainerInset.left + textView.textContainer.lineFragmentPadding),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -textView.textContainerInset.right - textView.textContainer.lineFragmentPadding),
        ])
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: textView
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: textView)
    }
    
    @objc func textDidChange() {
        placeholderLabel?.isHidden = !(textView?.text.isEmpty ?? true)

        if let maxCharacterCount = maxCharacterCount, let text = textView?.text, maxCharacterCount != 0, text.count > maxCharacterCount {
            truncateText(to: maxCharacterCount)
        }
    }

    private func truncateText(to count: Int) {
        guard let text = textView?.text else {
            return
        }

        let startIndex = text.startIndex
        let endIndex = text.index(startIndex, offsetBy: count - 1)
        let newText = String(text[startIndex ... endIndex])
        textView?.text = newText
    }

    private func createPlaceholderLabel() {
        guard let textView = textView else {
            return
        }

        let placeholderLabel = UILabel()
        placeholderLabel.font = textView.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)
        self.placeholderLabel = placeholderLabel

        updateConstraints()
        textDidChange()
    }
}
