//
//  FormViewDataSource.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import Foundation

public protocol FormViewDataSource {
    func numberOfInputs() -> Int
    func formView(_ formView: FormView?, viewForRowAt index: Int) -> FormInputView
}
