//
//  CarViewModelProtocol.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit
protocol ICarViewModel {
    var manufacturer: String { get }
    var model: String { get }
    var images: [UIImage?]? { get }
    var yearOfIssue: Int? { get }
    var fullName: String { get }
    var car: Car { get }
}
