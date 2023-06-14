//
//  NSObject+className.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import Foundation

 extension NSObject {
     static var className: String {
         String(describing: Self.self)
     }
 }
