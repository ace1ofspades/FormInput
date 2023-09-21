//
//  ConstraintInset.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import UIKit

struct ConstraintInset {
    var top: CGFloat?
    var left: CGFloat?
    var bottom: CGFloat?
    var right: CGFloat?
    var height: CGFloat?
    var width: CGFloat?

    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.height = height
        self.width = width
    }

    init(insets: UIEdgeInsets) {
        top = insets.top
        left = insets.left
        bottom = insets.bottom
        right = insets.right
    }
}

extension ConstraintInset {
    public static let zero:ConstraintInset = ConstraintInset(insets: .zero)
}
