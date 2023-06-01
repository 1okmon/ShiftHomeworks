//
//  CharacterDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class CharacterDetailsViewModel {
    private var coordinator: RickAndMortyCoordinator?
    private var character: Observable<CharacterDetails>
    
    init(coordinator: RickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.character = Observable<CharacterDetails>()
    }
    
    func subscribe(observer: IObserver) {
        self.character.subscribe(observer: observer)
    }
}
