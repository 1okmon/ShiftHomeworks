//
//  CarsViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

final class CarsViewModel {
    weak var coordinator : AppCoordinator?
    private var cars = Observable<[CarModel]>()
    
    func subscribe(observer: IObserver) {
        self.cars.subscribe(observer: observer)
        self.loadCars()
    }
    
    private func loadCars() {
        cars.value = CarsLoader.shared.cars()
    }
}

extension CarsViewModel: ICarsViewModel{
    func goToCarDetails(with id: Int) {
        self.coordinator?.goToCarDetails(with: id)
    }
}
