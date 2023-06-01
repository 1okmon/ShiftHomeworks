//
//  CharacterResponse.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import Foundation

struct CharacterResponse: Decodable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let image: String
}
