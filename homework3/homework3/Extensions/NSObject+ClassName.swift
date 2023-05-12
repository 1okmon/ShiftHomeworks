//
//  NSObject+ClassName.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
