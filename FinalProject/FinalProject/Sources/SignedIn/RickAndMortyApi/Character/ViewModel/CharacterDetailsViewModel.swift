//
//  CharacterDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class CharacterDetailsViewModel {
    private var coordinator: RickAndMortyCoordinator?
    private let charactersNetworkManager: RickAndMortyCharacterNetworkManager
    private var character: Observable<CharacterDetails>
    
    init(coordinator: RickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.charactersNetworkManager = RickAndMortyCharacterNetworkManager.shared
        self.character = Observable<CharacterDetails>()
    }
    
    func subscribe(observer: IObserver) {
        self.character.subscribe(observer: observer)
    }
    
    func loadCharacter(with id: Int) {
        self.charactersNetworkManager.loadCharacter(with: id) { [weak self] (character: CharacterDetails) in
            DispatchQueue.main.async {
                self?.character.value = character
                self?.loadImage(by: character.imageUrl)
            }

        }
    }
    
    func loadImage(by url: String) {
        self.charactersNetworkManager.loadImage(from: url) { [weak self] image, _ in
            self?.character.value?.image = image
        }
    }
}
