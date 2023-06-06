//
//  ICharacterCoreDataManager.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

import Foundation

protocol ICharacterCoreDataManager {
    func createCharacter(_ characterDetails: CharacterDetails)
    func fetchCharacters() -> [CharacterEntity]
    func fetchCharacter(with id: Int) -> CharacterEntity?
    func deleteAllCharacters()
    func deleteCharacter(with id: Int)
}
