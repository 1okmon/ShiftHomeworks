//
//  MultiThreadingArrayProtocols.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

protocol ArrayMetods {
    func append(_ item: Any)
    func remove(at index: Int)
    func element(at index: Int) -> Any
    func contains(_ element: Any) -> Bool
    func append(array: [Any])
}

protocol ArrayProperties {
    var isEmpty: Bool { get }
    var count: Int { get }
}
