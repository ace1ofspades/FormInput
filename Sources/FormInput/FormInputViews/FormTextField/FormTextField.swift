//
//  FormTextField.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormTextField sınıfı
open class FormTextField: FormInputView {
    @IBOutlet var textField: InsetTextField!
    @IBOutlet var titleLabel: UILabel?

    public override var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
            titleLabel?.isHidden = newValue == nil
        }
    }

    public override var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }

    public override var value: Any? {
        get {
            textField.text
        }
        set {
            textField.text = newValue as? String
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
        inputHeight = { 82 }
    }

    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}

class InsetTextField: UITextField {
    @IBInspectable var inset: CGFloat = 0 // The desired inset value

    init(inset: CGFloat) {
        self.inset = inset
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
