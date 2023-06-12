//
//  CharacterDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class CharacterDetailsViewModel: ICharacterDetailsViewModel {
    private var coordinator: ICharacterDetailsRickAndMortyCoordinator
    private let charactersNetworkManager: RickAndMortyCharacterNetworkManager
    private var character: Observable<CharacterDetails>
    private var errorCode: Observable<IAlertRepresentable>
    private let coreDataManager: ICharacterCoreDataManager
    private var isFavorite: Observable<Bool>
    
    init(coordinator: ICharacterDetailsRickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.coreDataManager = CoreDataManager.shared
        self.isFavorite = Observable<Bool>(false)
        self.errorCode = Observable<IAlertRepresentable>()
        self.charactersNetworkManager = RickAndMortyCharacterNetworkManager.shared
        self.character = Observable<CharacterDetails>()
    }
    
    func subscribe(observer: IObserver) {
        self.character.subscribe(observer: observer)
        self.isFavorite.subscribe(observer: observer)
        self.errorCode.subscribe(observer: observer)
    }
    
    func loadCharacter(with id: Int) {
        if let characterEntity = coreDataManager.fetchCharacter(with: id) {
            self.character.value = CharacterDetails(characterEntity: characterEntity)
            self.isFavorite.value = true
            return
        }
        self.charactersNetworkManager.loadCharacter(with: id) { [weak self] (character: CharacterDetails?, responseErrorCode) in
            guard let character = character else {
                self?.errorCode.value = responseErrorCode
                return
            }
            DispatchQueue.main.async {
                self?.isFavorite.value = self?.coreDataManager.fetchCharacter(with: id) != nil
                self?.character.value = character
                self?.loadImage(by: character.imageUrl)
            }
        }
    }
    
    func switchAddedInFavourites() {
        guard let character = self.character.value,
              let isFavorite = self.isFavorite.value else { return }
        if isFavorite {
            self.coreDataManager.deleteCharacter(with: character.id)
        } else {
            self.coreDataManager.createCharacter(character)
        }
        self.isFavorite.value = !isFavorite
    }
    
    func close() {
        self.coordinator.closePresentedController()
    }
    
    func loadImage(by url: String) {
        self.charactersNetworkManager.loadImage(from: url) { [weak self] image, _, responseErrorCode in
            self?.character.value?.image = image
        }
    }
}
