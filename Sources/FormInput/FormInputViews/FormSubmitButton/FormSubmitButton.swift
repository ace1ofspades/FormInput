//
//  File.swift
//
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

// FormSwitch sınıfı
open class FormSubmitButton: FormInputView {
    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.addTarget(self, action: #selector(submitButtonDidTapped), for: .touchUpInside)
        }
    }

    public var submitButtonTapped: (() -> Void)?

    public override var title: String? {
        get {
            submitButton.currentTitle
        }
        set {
            submitButton.setTitle(newValue, for: .normal)
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

    @objc func submitButtonDidTapped() {
        submitButtonTapped?()
    }

    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
