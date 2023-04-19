//
//  TestClassToCheckEquality.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

final class TestClassToCheckEquality: AbleToCheckEquality {
    var name = "sam"
    
    func equals(to: Any) -> Bool {
        guard let secondItem = to as? TestClassToCheckEquality else {
            return false
        }
        return self == secondItem
    }
    
    static func == (lhs: TestClassToCheckEquality, rhs: TestClassToCheckEquality) -> Bool {
        rhs.name == lhs.name
    }
}
