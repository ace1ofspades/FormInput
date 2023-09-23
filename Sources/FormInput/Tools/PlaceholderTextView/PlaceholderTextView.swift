//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

class PlaceholderTextView: UITextView {
    private var placeholderManager: PlaceholderManager?
    
    override var text: String! {
        get {
            return super.text
        }
        set {
            super.text = newValue
            placeholderManager?.textDidChange()
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return placeholderManager?.placeholder
        }
        set {
            if placeholderManager == nil {
                placeholderManager = PlaceholderManager(textView: self)
                placeholderManager?.maxCharacterCount = maxCharacterCount
            }
            placeholderManager?.placeholder = newValue
        }
    }
    
    @IBInspectable var maxCharacterCount: Int = 0 {
        didSet {
            placeholderManager?.maxCharacterCount = maxCharacterCount
        }
    }
    
    @IBInspectable var insetY: CGFloat = 0.0 {
        didSet {
            textContainerInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        }
    }
    
    @IBInspectable var insetX: CGFloat = 0.0 {
        didSet {
            textContainerInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override var textContainerInset: UIEdgeInsets {
        get {
            return super.textContainerInset
        }
        set {
            super.textContainerInset = newValue
            placeholderManager?.updateConstraints()
        }
    }
}
