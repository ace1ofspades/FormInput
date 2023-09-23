//
//  FormTextField.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormTextField sınıfı
class FormTextField: FormInputView {
    @IBOutlet var textField: InsetTextField!
    @IBOutlet var titleLabel: UILabel?

    override var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
        }
    }

    override var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }

    override var value: Any? {
        get {
            textField.text
        }
        set {
            textField.text = newValue as? String
        }
    }

    override func getDefaultHeight() -> CGFloat {
        return 82
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
    }

    override func showValidation() {
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
