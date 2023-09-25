//
//  FormPickerView.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// FormPickerView sınıfı
open class FormPickerView: FormInputView {
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapped))
            titleLabel.superview?.addGestureRecognizer(gesture)
        }
    }

    @IBOutlet var tagCollectionView: TagCollectionView! {
        didSet {
            tagCollectionView.semanticContentAttribute = .forceRightToLeft
            setTags()
        }
    }

    public var fetchPickerItems: (_ callback: @escaping PickerItemsCallback) -> Void = { _ in }
    public var searchPickerItems: (_ searchText: String?, _ items: [PickerItem], _ callback: @escaping SearchItemsCallback) -> Void = { _, _, _ in }
    public var itemSortingCallback: ItemSortingCallback = { ($0.title?.localizedLowercase ?? "") < ($1.title?.localizedLowercase ?? "") }
    public var fetchFilterArray: (_ item1: PickerItem, _ item2: PickerItem) -> Bool = { $0.id == $1.id }
    public var mapSelectedArray: (_ item: PickerItem) -> Any = { return $0 }
    
    public var itemCount:Int? = nil

    override public var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
            titleLabel?.isHidden = newValue == nil
        }
    }

    public var items: [PickerItem]?
    override public var initialItems: Any? {
        get {
            items
        }
        set {
            items = newValue as? [PickerItem]
        }
    }

    public var selectedItems: [PickerItem]?
    override public var value: Any? {
        get {
            selectedItems?.map(mapSelectedArray)
        }
        set {
            selectedItems = newValue as? [PickerItem]
        }
    }

    open override func getDefaultHeight() -> CGFloat {
        return inputHeight() + tagCollectionView.contentSize.height
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
        inputHeight = { 34 }
    }

    func setTags() {
        let tagItems = selectedItems?.enumerated().map({ item in
            let index = item.offset
            let element = item.element

            let tagItem = TagItem(title: element.title ?? "", icon: UIImage(systemName: "xmark"), tintColor: .red) {
                self.selectedItems?.remove(at: index)
                self.setTags()
            }
            return tagItem
        })

        tagCollectionView.items = tagItems ?? []
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.layoutSubviews()
        }
    }

    @objc func didTapped() {
        let pickerViewController: PickerViewController = PickerViewController(style: .insetGrouped, isSearchEnabled: true, isMultiSelection: true, selectionStyle: .section)
        pickerViewController.items = items ?? []
        pickerViewController.selectedItems = selectedItems ?? []
        pickerViewController.selectionDoneCallback = { selectedItems in
            self.value = selectedItems
            self.setTags()
        }
        pickerViewController.itemCount = itemCount
        pickerViewController.searchPickerItems = searchPickerItems
        pickerViewController.fetchFilterArray = fetchFilterArray
        pickerViewController.fetchPickerItems = fetchPickerItems

        parentViewController?.navigationController?.pushViewController(pickerViewController, animated: true)
    }

    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}

extension FormPickerView {
}
