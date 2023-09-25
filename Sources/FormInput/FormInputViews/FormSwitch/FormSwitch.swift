//
//  FormSwitch.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormSwitch sınıfı
open class FormSwitch: FormInputView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!

    public override var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    public override var value: Any? {
        get {
            switchButton.isOn
        }
        set {
            switchButton.isOn = newValue as? Bool ?? false
        }
    }

    open override func getDefaultHeight() -> CGFloat {
        return 44
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
    }

    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
