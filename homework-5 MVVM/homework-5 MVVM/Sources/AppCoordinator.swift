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
        viewModel.subscribe(observer: carsViewController)
        self.navigationController.viewControllers = [carsViewController]
    }
    
    func goToCarDetails(with id: Int) {
        let viewModel = CarDetailsViewModel(carId: id)
        viewModel.coordinator = self
        let carDetailsViewController = CarDetailsViewController(viewModel: viewModel)
        viewModel.subscribe(observer: carDetailsViewController)
        self.navigationController.pushViewController(carDetailsViewController, animated: true)
    }
    
    func goToCarPhotoCarousel(with id: Int) {
        let viewModel = CarPhotoCarouselViewModel(carId: id)
        viewModel.coordinator = self
        let carPhotoCarouselViewController = CarPhotoCarouselViewController(viewModel: viewModel)
        viewModel.subscribe(observer: carPhotoCarouselViewController)
        let navController = UINavigationController(rootViewController: carPhotoCarouselViewController)
        navController.modalPresentationStyle = .fullScreen
        self.navigationController.present(navController, animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true)
    }
}
