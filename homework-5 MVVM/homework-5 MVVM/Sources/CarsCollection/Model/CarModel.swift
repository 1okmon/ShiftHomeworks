//
//  CarModel.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

struct CarModel {
    var id: Int
    var manufacturer: String
    var model: String
    var images: [UIImage?]?
    var yearOfIssue: Int?
    var fullName: String {
        return self.manufacturer + " " + self.model
    }
}
