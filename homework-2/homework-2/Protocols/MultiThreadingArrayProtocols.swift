//
//  MultiThreadingArrayProtocols.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

protocol ArrayMetods {
    associatedtype T: Equatable
    func append(_ item: T)
    func remove(at index: Int)
    func element(at index: Int) -> T?
    func contains(_ element: T) -> Bool
    func append(array: [T])
}

protocol ArrayProperties {
    var isEmpty: Bool { get }
    var count: Int { get }
}
