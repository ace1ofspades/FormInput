//
//  FormTextView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 20.09.2023.
//

import UIKit

open class FormTextView: FormInputView {
    @IBOutlet var textView: PlaceholderTextView!
    @IBOutlet var titleLabel: UILabel?

    override public var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
            titleLabel?.isHidden = newValue == nil
        }
    }

    override public var placeholder: String? {
        get {
            textView.placeholder
        }
        set {
            textView.placeholder = newValue
        }
    }

    override public var value: Any? {
        get {
            textView.text
        }
        set {
            textView.text = newValue as? String
        }
    }

    override open func getDefaultHeight() -> CGFloat {
        return inputHeight()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        inputHeight = { 120 }
    }

    override open func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
