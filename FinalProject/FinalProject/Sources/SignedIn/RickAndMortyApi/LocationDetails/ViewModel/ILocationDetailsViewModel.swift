//
//  ILocationDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

protocol ILocationDetailsViewModel {
    func switchAddedInFavourites()
    func loadCharacters()
    func openCharacter(with id: Int)
    func goBack()
    func fetchIsFavorite()
}
