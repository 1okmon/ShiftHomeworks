//
//  CarModel.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

struct CarModel {
    var manufacturer: String
    var model: String
    var images: [UIImage?]?
    var yearOfIssue: Int?
    
    var fullName: String {
        manufacturer + " " + model
    }
    
    var yearOfIssueDescription: String {
        let result = "Year of issue:\t"
        guard let yearOfIssue = yearOfIssue else {
            return result + "unknown"
        }
        return result + String(describing: yearOfIssue)
    }
}
