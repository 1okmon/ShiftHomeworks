//
//  IFavoritesCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

protocol IFavoritesCoordinator {
    func goToCharacters()
    func goToLocations()
}

protocol IFavoriteCharactersCoordinator {
    func openCharacter(with id: Int, with completion: (() -> Void)?)
}
