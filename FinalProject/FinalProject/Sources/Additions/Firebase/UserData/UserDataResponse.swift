//
//  UserData.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

struct UserDataResponse: Decodable {
    var email: String
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    var favoriteLocations: [Int]?
    var favoriteCharacters: [Int]?
}
