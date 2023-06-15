//
//  RickAndMortyCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Title {
    static let locationsViewController = "Локации"
}
class RickAndMortyCoordinator: ILocationsRickAndMortyCoordinator, ILocationDetailsRickAndMortyCoordinator, ICharacterDetailsRickAndMortyCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.start()
    }
    
    func start() {
        self.goToLocations()
    }
    
    func goToLocations() {
        let locationsViewModel = LocationsViewModel(coordinator: self)
        let locationsViewController = LocationsViewController(viewModel: locationsViewModel)
        locationsViewModel.subscribe(observer: locationsViewController)
        locationsViewController.title = Title.locationsViewController
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
    
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func closePresentedController() {
        self.navigationController.dismiss(animated: true)
    }
}
