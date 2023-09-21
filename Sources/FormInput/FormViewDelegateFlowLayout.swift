//
//  FormViewDelegateFlowLayout.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

// Protocol'ler
public protocol FormViewDelegateFlowLayout {
    func spacing() -> CGFloat?
    func formView(_ formView: FormView?, insetForRowAt index: Int) -> UIEdgeInsets
    func formView(_ formView: FormView?, heightForRowAt index: Int) -> CGFloat?
}
