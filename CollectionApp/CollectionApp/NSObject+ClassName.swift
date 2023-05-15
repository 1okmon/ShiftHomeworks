//
//  NSObject+ClassName.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
