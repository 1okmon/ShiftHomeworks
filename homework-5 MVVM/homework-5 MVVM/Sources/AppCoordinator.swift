//
//  AppCoordinator.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

class AppCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CarsViewModel()
        viewModel.coordinator = self
        let carsViewController = CarsViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [carsViewController]
    }
    
    func goToCarDetails(with car: Car) {
        let viewModel = CarDetailsViewModel(car: car)
        viewModel.coordinator = self
        let carDetailsViewController = CarDetailsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(carDetailsViewController, animated: true)
    }
    
    func goToCarPhotoCarousel(with car: Car) {
        let viewModel = CarPhotoCarouselViewModel(car: car)
        viewModel.coordinator = self
        let carPhotoCarouselViewController = CarPhotoCarouselViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: carPhotoCarouselViewController)
        navController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true)
    }
}
