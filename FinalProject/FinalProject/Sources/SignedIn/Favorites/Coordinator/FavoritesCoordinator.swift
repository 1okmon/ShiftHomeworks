//
//  FavoritesCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

import UIKit

private enum Metrics {
    static let navigationControllerTitle = "Избранное"
    static let favoriteLocationsTitle = "Избранные локации"
    static let favoriteCharactersTitle = "Избранные персонажи"
}

final class FavoritesCoordinator: RickAndMortyCoordinator, IFavoritesCoordinator, IFavoriteCharactersCoordinator {
    private var navigationController: UINavigationController
    
    override init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(navigationController: self.navigationController)
        start()
    }
    
    override func start() {
        goToFavorites()
    }
    
    private func goToFavorites() {
        let favoritesViewModel = FavoritesViewModel(coordinator: self)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        favoritesViewController.title = Metrics.navigationControllerTitle
        self.navigationController.viewControllers = [favoritesViewController]
    }
    
    override func goToLocations() {
        let favoriteLocationsViewModel = FavoriteLocationsViewModel(coordinator: self)
        let favoriteLocationsViewController = FavoriteLocationsViewController(viewModel: favoriteLocationsViewModel)
        favoriteLocationsViewModel.subscribe(observer: favoriteLocationsViewController)
        favoriteLocationsViewController.title = Metrics.favoriteLocationsTitle
        self.navigationController.pushViewController(favoriteLocationsViewController, animated: true)
    }
    
    func goToCharacters() {
        let favoriteCharactersViewController = FavoriteCharactersViewController()
        let favoriteCharactersPresenter = FavoriteCharactersPresenter(viewController: favoriteCharactersViewController, coordinator: self)
        favoriteCharactersViewController.setPresenter(favoriteCharactersPresenter)
        favoriteCharactersViewController.title = Metrics.favoriteCharactersTitle
        self.navigationController.pushViewController(favoriteCharactersViewController, animated: true)
    }
    
    func openCharacter(with id: Int, with completion: (() -> Void)?) {
        let characterDetailsViewModel = CharacterDetailsViewModel(coordinator: self)
        let characterDetailsViewController = CharacterDetailsViewController(viewModel: characterDetailsViewModel)
        characterDetailsViewModel.subscribe(observer: characterDetailsViewController)
        characterDetailsViewModel.loadCharacter(with: id)
        characterDetailsViewController.dismissCompletion = completion
        self.navigationController.present(characterDetailsViewController, animated: true)
    }
}
