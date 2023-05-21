//
//  CarsJSONModel.swift
//  homework-5 MVVM
//
//  Created by 1okmon on 21.05.2023.
//

import Foundation

struct CarModelJson: Decodable {
    var id: Int
    var manufacturer: String
    var model: String
    var images: [String]?
    var yearOfIssue: Int?
}

struct CarsModelJson: Decodable {
    var cars: [CarModelJson]
}
