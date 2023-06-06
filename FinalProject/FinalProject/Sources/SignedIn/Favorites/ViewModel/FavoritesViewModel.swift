//
//  FavoritesViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

import Foundation

final class FavoritesViewModel {
    private var coordinator: FavoritesCoordinator?
    
    init(coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToLocations() {
        self.coordinator?.goToLocations()
    }
    
    func goToCharacters() {
        self.coordinator?.goToCharacters()
    }
}
