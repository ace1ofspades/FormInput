//
//  FormTextView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 20.09.2023.
//

import UIKit

class FormTextView: FormInputView {
    @IBOutlet var textView: PlaceholderTextView!
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
            textView.placeholder
        }
        set {
            textView.placeholder = newValue
        }
    }

    override var value: Any? {
        get {
            textView.text
        }
        set {
            textView.text = newValue as? String
        }
    }

    override func getDefaultHeight() -> CGFloat {
        return 120
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
