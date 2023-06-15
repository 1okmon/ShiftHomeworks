//
//  CharacterResponse.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

struct CharacterResponse: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}
