//
//  CharacterDetails.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

struct CharacterDetails: ICharacter {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let imageUrl: String
    var image: UIImage?
    
    init(characterResponse: CharacterResponse) {
        self.id = characterResponse.id
        self.name = characterResponse.name
        self.status = characterResponse.status
        self.species = characterResponse.species
        self.type = characterResponse.type
        self.gender = characterResponse.gender
        self.imageUrl = characterResponse.image
    }
}
