//
//  CarPhotoCarouselViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

final class CarPhotoCarouselViewModel {
    weak var coordinator : AppCoordinator?
    private var car: Observable<CarPhotoCarouselModel>
    private var carPhotoCarouselModel: CarPhotoCarouselModel?
    private var carId: Int

    init(carId: Int) {
        self.carId = carId
        self.car = Observable<CarPhotoCarouselModel>()
    }
    
    func subscribe(observer: IObserver) {
        self.car.subscribe(observer: observer)
        self.loadCar()
    }
    
    private func loadCar() {
        guard let car = CarsLoader.shared.car(with: carId) else { return }
        self.car.value = CarPhotoCarouselModel(images: car.images)
    }
}

extension CarPhotoCarouselViewModel: ICarPhotoCarouselViewModel {
    func dismiss() {
        self.coordinator?.dismiss()
    }
}
