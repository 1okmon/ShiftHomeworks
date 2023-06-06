//
//  CarsViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

final class CarsViewModel {
    weak var coordinator: AppCoordinator?
    private var cars = Observable<[CarModel]>()
    
    func subscribe(observer: IObserver) {
        self.cars.subscribe(observer: observer)
        self.loadCars()
    }
}

extension CarsViewModel: ICarsViewModel {
    func goToCarDetails(with carId: Int) {
        self.coordinator?.goToCarDetails(with: carId)
    }
}

private extension CarsViewModel {
    func loadCars() {
        cars.value = CarsLoader.shared.cars()
    }
}
