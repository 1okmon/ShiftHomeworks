//
//  CarDetailsViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

final class CarDetailsViewModel {
    weak var coordinator: AppCoordinator?
    private var car: Observable<CarDetailModel>
    private var carId: Int

    init(carId: Int) {
        self.carId = carId
        self.car = Observable<CarDetailModel>()
    }
    
    func subscribe(observer: IObserver) {
        self.car.subscribe(observer: observer)
        self.loadCar()
    }
}

extension CarDetailsViewModel: ICarDetailsViewModel {
    func goToCarPhotoCarousel(with carId: Int) {
        self.coordinator?.goToCarPhotoCarousel(with: carId)
    }
}

private extension CarDetailsViewModel {
    func loadCar() {
        guard let car = CarsLoader.shared.car(with: carId) else { return }
        self.car.value = CarDetailModel(id: car.id,
                                        fullName: car.fullName,
                                        yearOfIssue: car.yearOfIssue,
                                        carPhoto: car.images?.first ?? nil)
    }
}
