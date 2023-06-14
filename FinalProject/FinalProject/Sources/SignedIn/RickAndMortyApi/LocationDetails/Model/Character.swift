//
//  Character.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import Foundation
struct Character: ICharacter {
    let id: Int
    let name: String
    let image: String
    
    init(characterResponse: CharacterResponse) {
        self.id = characterResponse.id
        self.name = characterResponse.name
        self.image = characterResponse.image
    }
}
