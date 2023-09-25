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
    
    public override var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
        }
    }

    public override var placeholder: String? {
        get {
            textView.placeholder
        }
        set {
            textView.placeholder = newValue
        }
    }

    public override var value: Any? {
        get {
            textView.text
        }
        set {
            textView.text = newValue as? String
        }
    }

    open override func getDefaultHeight() -> CGFloat {
        return 120
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
