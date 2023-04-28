//
//  GetAlexInfoProtocol.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation

protocol GetAlexInfoProtocol {
    associatedtype T
    static func getAlexProfileInfo() -> T
}
