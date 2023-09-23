//
//  File.swift
//
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

class TagItem {
    var title: String
    var icon: UIImage?
    var iconSize: CGFloat!
    var tintColor: UIColor = .black
    var didTapped: () -> Void

    init(title: String, icon: UIImage? = nil, iconSize: CGFloat = 18, tintColor: UIColor = .black, didTapped: @escaping () -> Void = {}) {
        self.title = title
        self.icon = icon
        self.iconSize = iconSize
        self.tintColor = tintColor
        self.didTapped = didTapped
    }
}
