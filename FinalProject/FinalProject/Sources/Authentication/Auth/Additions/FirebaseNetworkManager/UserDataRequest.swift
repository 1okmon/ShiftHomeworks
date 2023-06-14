//
//  UserData.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import Foundation

struct UserDataResponse: Decodable {
    var email: String
    var name: String?
    var favoriteLocations: [Int]?
    var favoriteCharacters: [Int]?
}

enum UserDataRequest {
    case email(email: String)
    case name(name: String)
    case favoriteLocations(locationsIds: [Int])
    case favoriteCharacters(charactersIds: [Int])
    
    var fieldName: String {
        switch self {
        case .email:
            return "email"
        case .name:
            return "name"
        case .favoriteLocations:
            return "favoriteLocations"
        case .favoriteCharacters:
            return "favoriteCharacters"
        }
    }
    var value: [String: Any] {
        var array = [String: Any]()
        switch self {
        case .email(let email):
            array.updateValue(email, forKey: self.fieldName)
        case .name(let name):
            array.updateValue(name, forKey: self.fieldName)
        case .favoriteLocations(let locationsIds):
            array.updateValue(locationsIds, forKey: self.fieldName)
        case .favoriteCharacters(let charactersIds):
            array.updateValue(charactersIds, forKey: self.fieldName)
        }
        return array
    }
    
    static func userData(email: String, name: String, favoriteLocations: [Int], favoriteCharacters: [Int]) -> [String: Any] {
        var result = [String: Any]()
        let nameValue = self.name(name: name).value
        let emailValue = self.email(email: email).value
        let favoriteLocationsValue = self.favoriteLocations(locationsIds: favoriteLocations).value
        let favoriteCharactersValue = self.favoriteCharacters(charactersIds: favoriteCharacters).value
        nameValue.forEach { result.updateValue($0.value, forKey: $0.key) }
        emailValue.forEach { result.updateValue($0.value, forKey: $0.key) }
        favoriteLocationsValue.forEach { result.updateValue($0.value, forKey: $0.key) }
        favoriteCharactersValue.forEach { result.updateValue($0.value, forKey: $0.key) }
        return result
    }
}
