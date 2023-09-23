//
//  FormSwitch.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormSwitch sınıfı
class FormSwitch: FormInputView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!

    override var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }

    override var value: Any? {
        get {
            switchButton.isOn
        }
        set {
            switchButton.isOn = newValue as? Bool ?? false
        }
    }

    override func getDefaultHeight() -> CGFloat {
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
    }

    override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}
