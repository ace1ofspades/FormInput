//
//  File.swift
//
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

// FormSwitch sınıfı
public class FormSubmitButton: FormInputView {
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

    public override func getDefaultHeight() -> CGFloat {
        return 44
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
        submitButtonTapped = {
            guard let form = self.superview?.superview?.superview?.superview as? FormView else { return }
            form.submit()
        }
    }

    @objc func submitButtonDidTapped() {
        submitButtonTapped?()
    }

    public override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
