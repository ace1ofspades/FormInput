//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import Foundation

public struct PickerItem {
    public let id: String = UUID().uuidString
    public var title: String?
    public var subtitle: String?
    public var item: Any?

    public init(title: String? = nil, subtitle: String? = nil, item: Any? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.item = item
    }
}
