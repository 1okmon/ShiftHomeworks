//
//  CarDetailsViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

final class CarDetailsViewModel {
    weak var coordinator : AppCoordinator?
    private var carModel: CarModel
    private var carEntity : Car
    
    init(car: Car) {
        self.carModel = car.carModel
        self.carEntity = car
    }
}

extension CarDetailsViewModel: ICarDetailsViewModelData {
    var car: Car {
        self.carEntity
    }
    
    var fullName: String {
        self.carModel.manufacturer + " " + self.carModel.model
    }
    
    var yearOfIssue: String {
        let result = "Year of issue:\t"
        guard let yearOfIssue = self.carModel.yearOfIssue else {
            return result + "unknown"
        }
        return result + String(describing: yearOfIssue)
    }
    
    var carPhoto: UIImage? {
        guard let carPhoto = self.carModel.images?.first else {
            return Images.defaultForCar
        }
        return carPhoto
    }
}

extension CarDetailsViewModel: ICarDetailsViewModelCoordinator {
    func goToCarPhotoCarousel(with car: Car) {
        self.coordinator?.goToCarPhotoCarousel(with: car)
    }
}
