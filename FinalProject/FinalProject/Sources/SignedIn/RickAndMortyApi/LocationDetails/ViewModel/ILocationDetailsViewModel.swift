//
//  ILocationDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import Foundation

protocol ILocationDetailsViewModel {
    func switchAddedInFavourites()
    func loadCharacters()
    func openCharacter(with id: Int)
}
