//
//  CarViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

final class CarViewModel {
    private var carModel: CarModel
    private var carEntity: Car
    
    init(car: Car) {
        self.carModel = car.carModel
        self.carEntity = car
    }
}

extension CarViewModel: ICarViewModel {
    var car: Car {
        self.carEntity
    }
    
    var manufacturer: String {
        carModel.manufacturer
    }
    
    var model: String {
        carModel.model
    }
    
    var images: [UIImage?]? {
        carModel.images
    }
    
    var yearOfIssue: Int? {
        carModel.yearOfIssue
    }
    
    var fullName: String {
        return carModel.manufacturer + " " + carModel.model
    }
}
