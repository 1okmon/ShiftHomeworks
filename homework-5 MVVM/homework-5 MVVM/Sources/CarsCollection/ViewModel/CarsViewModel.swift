//
//  CarsViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import Foundation

final class CarsViewModel {
    weak var coordinator : AppCoordinator?
}

extension CarsViewModel: ICarsViewModelsData {
    var allCarsViewModel: [ICarViewModel] {
        var carModels = [CarViewModel]()
        for car in Car.allCases {
            carModels.append(CarViewModel(car: car))
        }
        return carModels
    }
    
    func carViewModel(car: Car) -> CarViewModel {
        CarViewModel(car: car)
    }
}

extension CarsViewModel: ICarsViewModelCoordinator {
    func goToCarDetails(with car: Car) {
        coordinator?.goToCarDetails(with: car)
    }
}
