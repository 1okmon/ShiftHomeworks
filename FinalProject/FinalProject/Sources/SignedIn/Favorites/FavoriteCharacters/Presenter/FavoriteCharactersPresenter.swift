//
//  FavoriteCharactersPresenter.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

final class FavoriteCharactersPresenter: IFavoriteCharactersPresenter {
    private unowned var viewController: FavoriteCharactersViewController
    private var characters: [Int: Character]
    private var charactersImages: [String: UIImage?]
    private var coreDataManager: ICharacterCoreDataManager
    private var coordinator: ICharacterFavoritesCoordinator?
    
    init(viewController: FavoriteCharactersViewController, coordinator: ICharacterFavoritesCoordinator) {
        self.viewController = viewController
        self.charactersImages = [:]
        self.coreDataManager = CoreDataManager.shared
        self.characters = [:]
        self.coordinator = coordinator
    }
    
    func loadFavoritesCharacters() {
        let charactersEntity = coreDataManager.fetchCharacters()
        var charactersCopy = self.characters
        for characterEntity in charactersEntity {
            let characterId = Int(characterEntity.id)
            charactersCopy[characterId] = nil
            guard self.characters[characterId] == nil else { continue }
            self.characters.updateValue(Character(characterEntity: characterEntity), forKey: characterId)
            if let imageData = characterEntity.image,
               let imageUrl = characterEntity.imageUrl {
                let image = UIImage(data: imageData)
                self.charactersImages.updateValue(image, forKey: imageUrl)
            }
        }
        charactersCopy.forEach { (characterId, character) in
            self.characters[characterId] = nil
            self.charactersImages[character.image] = nil
        }
        self.viewController.update(with: Array(self.characters.values))
        self.viewController.update(with: self.charactersImages)
    }
    
    func openCharacter(with id: Int) {
        self.coordinator?.openCharacter(with: id, with: { [weak self] in
            self?.loadFavoritesCharacters()
        })
    }
}
