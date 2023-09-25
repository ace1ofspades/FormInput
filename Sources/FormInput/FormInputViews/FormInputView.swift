//
//  FormInputView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

public typealias ValidationCallback = (_ value: Any?, _ isRequired: Bool) -> Bool
// FormInputView sınıfı
open class FormInputView: UIView {
    public var name: String?
    public var placeholder: String?
    public var title: String?
    public var value: Any?
    public var initialItems: Any?
    public var errorMessage: String?
    public var isRequired: Bool = false
    public var validationRule: ValidationCallback = { $0 != nil || !$1 }

    open func showValidation() {
    }

    public var parentViewController: UIViewController? { (superview as? FormStackView)?.parentViewController }

    public var inputHeight: () -> CGFloat = { 40 }
    open func getDefaultHeight() -> CGFloat { inputHeight() }

    open func configure(
        name: String? = nil,
        placeholder: String? = nil,
        title: String? = nil,
        value: Any? = nil,
        initialItems: Any? = nil,
        errorMessage: String? = nil,
        isRequired: Bool,
        validationRule: @escaping ValidationCallback = { $0 != nil || !$1 }
    ) {
        self.name = name
        self.placeholder = placeholder
        self.title = title
        self.value = value
        self.initialItems = initialItems
        self.errorMessage = errorMessage
        self.isRequired = isRequired
        self.validationRule = validationRule
    }

    public convenience init(name: String? = nil, value: Any? = nil, isRequired: Bool = false) {
        self.init()
        self.name = name
        self.value = value
        self.isRequired = isRequired
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public extension FormInputView {
    static func create(
        name: String? = nil,
        placeholder: String? = nil,
        title: String? = nil,
        value: Any? = nil,
        errorMessage: String? = nil,
        isRequired: Bool = false,
        validationRule: @escaping ValidationCallback = { $0 != nil || !$1 },
        type: FormInputType
    ) -> FormInputView? {
        var formInputView: FormInputView!
        switch type {
        case .SmallText:
            guard let view = FormTextField.viewFromNib else { return nil }
            formInputView = view
        case .LargeText:
            guard let view = FormTextView.viewFromNib else { return nil }
            formInputView = view
        case .TagText:
            guard let view = FormTextFieldWithTags.viewFromNib else { return nil }
            formInputView = view
        case .Picker:
            guard let view = FormPickerView.viewFromNib else { return nil }
            formInputView = view
        case .PhotoPicker:
            guard let view = FormPhotoPicker.viewFromNib else { return nil }
            formInputView = view
        case .Switch:
            guard let view = FormSwitch.viewFromNib else { return nil }
            formInputView = view
        case .DatePicker:
            guard let view = FormDatePicker.viewFromNib else { return nil }
            formInputView = view
        case .SubmitButton:
            guard let view = FormSubmitButton.viewFromNib else { return nil }
            formInputView = view
        }

        formInputView.configure(name: name, placeholder: placeholder, title: title, value: value, errorMessage: errorMessage, isRequired: isRequired, validationRule: validationRule)
        return formInputView
    }
}

extension UIView {
    static var className: String { String(describing: self.self) }
    static var nib: UINib { UINib(nibName: Self.className, bundle: Bundle.module) }
}

extension UIView {
    static var viewFromNib: Self? {
        return Bundle.module.loadNibNamed(className, owner: nil)?.first as? Self
    }
}
