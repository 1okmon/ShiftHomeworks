//
//  CarDetailModel.swift
//  CollectionApp
//
//  Created by 1okmon on 07.05.2023.
//

import UIKit

private enum Metrics {
    static let yearOfIssuePrefix = "Year of Issue: "
    static let yearOfIssueUnknown = yearOfIssuePrefix + "Unknown"
}

struct CarDetailModel {
    let id: Int
    let fullName: String
    let yearOfIssue: Int?
    let carPhoto: UIImage?
    var yearOfIssueDescription: String {
        guard let yearOfIssue = self.yearOfIssue else {
            return Metrics.yearOfIssueUnknown
        }
        return Metrics.yearOfIssuePrefix + yearOfIssue.description
    }
}
