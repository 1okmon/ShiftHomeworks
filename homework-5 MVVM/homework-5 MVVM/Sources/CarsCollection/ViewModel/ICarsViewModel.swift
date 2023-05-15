//
//  CarsViewModelProtocol.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

typealias ICarsViewModel = ICarsViewModelsData & ICarsViewModelCoordinator

protocol ICarsViewModelsData {
    var allCarsViewModel: [ICarViewModel] { get }
    func carViewModel(car: Car) -> CarViewModel
}

protocol ICarsViewModelCoordinator {
    func goToCarDetails(with car: Car)
}
