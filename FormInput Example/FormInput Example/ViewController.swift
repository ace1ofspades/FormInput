//
//  ViewController.swift
//  FormInput Example
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import FormInput
import UIKit

class ViewController: UIViewController {
    var formView: FormView? { view as? FormView }
    
    let items = [
        PickerItem(title: "Test1", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test2", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test3", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test4", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test5", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test6", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test7", subtitle: "Test", item: "Test"),
    ]

    let searchItems = [
        PickerItem(title: "Test1", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test2", subtitle: "Test", item: "Test"),
        PickerItem(title: "Test3", subtitle: "Test", item: "Test"),
        PickerItem(title: "Search1", subtitle: "Test", item: "Test"),
        PickerItem(title: "Search2", subtitle: "Test", item: "Test"),
        PickerItem(title: "Search3", subtitle: "Test", item: "Test"),
        PickerItem(title: "Search4", subtitle: "Test", item: "Test"),
    ]

    let selectedItems = [
        PickerItem(title: "Selected1", subtitle: "Test", item: "Test"),
        PickerItem(title: "Selected2", subtitle: "Test", item: "Test"),
        PickerItem(title: "Selected3", subtitle: "Test", item: "Test"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formView?.parentViewController = self

        let smallTextInput = FormInputView.create(name: "header", type: .SmallText)
        let tagTextInput = FormInputView.create(name: "tags", type: .TagText)
        let switchInput = FormInputView.create(name: "switch", value: true, type: .Switch)
        let pickerInput = createPickerInput()
        let pickerInput2 = createPickerInput()
        let pickerInput3 = createPickerInput()
        let pickerInput4 = createPickerInput()
        let photoPickerInput = FormInputView.create(name: "photos", type: .PhotoPicker)
        let largeTextInput = FormInputView.create(name: "largeText", type: .LargeText)
        let datePickerInput = FormInputView.create(name: "largeText", type: .DatePicker)
        let submitButton = FormInputView.create(name: "submit", type: .SubmitButton)

        smallTextInput?.placeholder = "Tek Satır Yazısı"
        tagTextInput?.placeholder = "Tek Satır Yazısı"
        largeTextInput?.placeholder = "Büyük Yazı"
        smallTextInput?.title = "Başlık"
        datePickerInput?.title = "Başlık"
        tagTextInput?.title = "Tagler"
        largeTextInput?.title = "Açıklama"
        switchInput?.title = "Buton aç kapa"
        photoPickerInput?.title = "Fotoğraf seçin"
        
        formView?.onSubmit = { jsonValue in
            print(jsonValue)
        }

        formView?.formElements = [
            photoPickerInput,
            smallTextInput,
            tagTextInput,
            largeTextInput,
            pickerInput,
            pickerInput2,
            pickerInput3,
            pickerInput4,
            datePickerInput,
            switchInput,
            submitButton,
        ]
        
        
    }
    
    func createPickerInput() -> FormPickerView? {
        let pickerInput = FormInputView.create(name: "picker", type: .Picker) as? FormPickerView
        pickerInput?.title = "Seçmek istediğini seç"
        pickerInput?.searchPickerItems = { searchText, _, callback in
            guard let searchText = searchText else { return }
            let searchItems = self.searchItems.filter { $0.title?.localizedLowercase.contains(searchText.localizedLowercase) ?? false }
            callback(searchItems)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                callback(searchItems)
            }
        }
        pickerInput?.fetchFilterArray = { $0.title == $1.title }
        pickerInput?.mapSelectedArray = { $0.item }
        pickerInput?.itemCount = 10
        pickerInput?.fetchPickerItems = { callback in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                callback(self.items, pickerInput?.selectedItems as? [PickerItem] ?? [])
            }
        }
        
        pickerInput?.backgroundColor = .blue
        pickerInput?.value = selectedItems
        return pickerInput
    }
    
}
