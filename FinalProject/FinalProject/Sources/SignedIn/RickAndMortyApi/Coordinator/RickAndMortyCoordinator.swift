//
//  RickAndMortyCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Title {
    static let forLocationViewController = "Локации"
}
class RickAndMortyCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        start()
    }
    
    func start() {
        goToLocations()
    }
    
    func goToLocations() {
        let locationsViewModel = LocationsViewModel(coordinator: self)
        let locationsViewController = LocationsViewController(viewModel: locationsViewModel)
        locationsViewModel.subscribe(observer: locationsViewController)
        locationsViewController.title = Title.forLocationViewController
        self.navigationController.viewControllers = [locationsViewController]
    }
    
    func openLocation(with id: Int) {
        let locationViewModel = LocationDetailsViewModel(coordinator: self)
        let locationViewController = LocationDetailsViewController(viewModel: locationViewModel)
        locationViewModel.subscribe(observer: locationViewController)
        locationViewModel.loadLocation(with: id)
        self.navigationController.pushViewController(locationViewController, animated: true)
    }
    
    func openCharacter(with id: Int) {
        let characterDetailsViewModel = CharacterDetailsViewModel(coordinator: self)
        let characterDetailsViewController = CharacterDetailsViewController(viewModel: characterDetailsViewModel)
        characterDetailsViewModel.subscribe(observer: characterDetailsViewController)
        characterDetailsViewModel.loadCharacter(with: id)
        self.navigationController.present(characterDetailsViewController, animated: true)
    }
}
