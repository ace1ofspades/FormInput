//
//  FormTextField.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormTextField sınıfı
open class FormTextFieldWithTags: FormInputView {
    @IBOutlet var textField: InsetTextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet var titleLabel: UILabel?

    @IBOutlet var tagCollectionView: TagCollectionView! {
        didSet {
            tagCollectionView.semanticContentAttribute = .forceRightToLeft
            setTags()
        }
    }
    
    public override var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
            titleLabel?.isHidden = newValue == nil
        }
    }

    public override var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    var textList:[String] = []
    public override var value: Any? {
        get {
            textList
        }
        set {
            textList = newValue as? [String] ?? []
        }
    }

    open override func getDefaultHeight() -> CGFloat {
        return inputHeight() + 8 + tagCollectionView.contentSize.height
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint?.constant = getDefaultHeight()
        superview?.layoutSubviews()
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
        inputHeight = { 82 }
    }
    
    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
    
    func setTags() {
        let tagItems = textList.enumerated().map({ item in
            let index = item.offset
            let element = item.element

            let tagItem = TagItem(title: element, icon: UIImage(systemName: "xmark"), tintColor: .red) {
                self.textList.remove(at: index)
                self.setTags()
            }
            return tagItem
        })

        tagCollectionView.items = tagItems ?? []
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.layoutSubviews()
        }
    }
    
    
}


extension FormTextFieldWithTags: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text?.replacingOccurrences(of: " ", with: ""), !text.isEmpty {
            textList.insert(text, at: 0)
            textField.text = ""
            setTags()
        }
        return true
    }
}
