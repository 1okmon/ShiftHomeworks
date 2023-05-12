//
//  TestClassToCheckEquality.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

final class TestClassToCheckEquality: Equatable {
    var name = "Sam"

    static func == (lhs: TestClassToCheckEquality, rhs: TestClassToCheckEquality) -> Bool {
        rhs.name == lhs.name
    }
}
