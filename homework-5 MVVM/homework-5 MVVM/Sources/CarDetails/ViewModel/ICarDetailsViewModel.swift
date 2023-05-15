//
//  CarDetailsViewModelProtocol.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

typealias ICarDetailsViewModel = ICarDetailsViewModelData & ICarDetailsViewModelCoordinator

protocol ICarDetailsViewModelData {
    var fullName:String { get }
    var yearOfIssue: String { get }
    var carPhoto: UIImage? { get }
    var car: Car { get }
}

protocol ICarDetailsViewModelCoordinator {
    func goToCarPhotoCarousel(with car: Car)
}
