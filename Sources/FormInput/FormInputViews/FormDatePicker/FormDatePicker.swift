//
//  File.swift
//
//
//  Created by Yusuf Tekin on 25.09.2023.
//

import UIKit

// FormSwitch sınıfı
open class FormDatePicker: FormInputView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!

    override public var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public var minimumDate: Date? {
        get {
            datePicker.minimumDate
        }
        set {
            datePicker.minimumDate = newValue
        }
    }
    public var maximumDate: Date? {
        get {
            datePicker.maximumDate
        }
        set {
            datePicker.maximumDate = newValue
        }
    }

    override public var value: Any? {
        get {
            datePicker.date
        }
        set {
            datePicker.date = newValue as? Date ?? Date()
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
        inputHeight = { 44 }
    }

    override open func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
