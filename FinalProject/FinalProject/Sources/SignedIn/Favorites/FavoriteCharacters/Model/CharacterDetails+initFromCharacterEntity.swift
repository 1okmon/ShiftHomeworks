//
//  CharacterDetails+initFromCharacterEntity.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

extension CharacterDetails {
    init(characterEntity: CharacterEntity) {
        self.id = Int(characterEntity.id)
        self.name = characterEntity.name ?? String()
        self.gender = characterEntity.gender ?? String()
        self.imageUrl = characterEntity.imageUrl ?? String()
        self.species = characterEntity.species ?? String()
        self.status = characterEntity.status ?? String()
        self.type = characterEntity.type ?? String()
        if let imageData = characterEntity.image {
            self.image = UIImage(data: imageData)
        }
    }
}
