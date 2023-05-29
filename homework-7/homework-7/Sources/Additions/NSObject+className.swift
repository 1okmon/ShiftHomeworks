//
//  NSObject+className.swift
//  homework7
//
//  Created by 1okmon on 27.05.2023.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
