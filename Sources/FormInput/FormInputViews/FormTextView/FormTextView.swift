//
//  FormTextView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 20.09.2023.
//

import UIKit

class FormTextView: FormInputView {
    @IBOutlet var textView: PlaceholderTextView!
    
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

    func configure(name: String? = nil, value: Any? = nil, type: FormInputType? = nil) {
        self.name = name
        self.value = value
        self.type = type
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
}
