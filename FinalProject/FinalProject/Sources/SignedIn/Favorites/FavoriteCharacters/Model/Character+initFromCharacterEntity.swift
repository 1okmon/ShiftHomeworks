//
//  Character+initFromCharacterEntity.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

extension Character {
    init(characterEntity: CharacterEntity) {
        self.id = Int(characterEntity.id)
        self.name = characterEntity.name ?? String()
        self.image = characterEntity.imageUrl ?? String()
    }
}
