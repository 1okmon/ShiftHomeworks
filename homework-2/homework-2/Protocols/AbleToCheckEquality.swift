//
//  AbleToCheckEquality.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

protocol AbleToCheckEquality: Equatable {
    func equals(to: Any) -> Bool
}
