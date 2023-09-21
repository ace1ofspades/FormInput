//
//  FormInputView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormInputView sınıfı
public class FormInputView: UIView {
    var name: String?
    var value: Any?
    var type: FormInputType?
    var parentViewController: UIViewController? { (superview as? FormStackView)?.parentViewController }

    func getDefaultHeight() -> CGFloat {
        return 40
    }

    convenience init(name: String? = nil, value: Any? = nil, type: FormInputType? = nil) {
        self.init()
        self.name = name
        self.value = value
        self.type = type
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public extension FormInputView {
    static func create(name: String? = nil, value: Any? = nil, type: FormInputType) -> FormInputView {
        switch type {
        case .SmallText:
            return FormTextField(name: name, value: value, type: type)
        case .LargeText:
            if let view = FormTextView.viewFromNib {
                view.configure(name: name, value: value, type: type)
                return view
            }
            return FormTextView(name: name, value: value, type: type)
        case .Picker:
            return FormPickerView(name: name, value: value, type: type)
        case .PhotoPicker:
            return FormPhotoPicker(name: name, value: value, type: type)
        case .Switch:
            return FormSwitch(name: name, value: value, type: type)
        }
    }
}

extension UIView {
    static var className: String { String(describing: self.self) }
    static var nib: UINib { UINib(nibName: Self.className, bundle: Bundle.module) }
}

extension UIView {
    static var viewFromNib: Self? {
        return Bundle.module.loadNibNamed(className, owner: nil)?.first as? Self
    }
}
