//
//  UserDataRequestBuilder.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

private enum FieldTitle: String {
    case email
    case firstName
    case lastName
    case imageUrl
    case favoriteLocations
    case favoriteCharacters
}

final class UserDataRequestBuilder {
    var email: String?
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    var favoriteLocations: [Int]?
    var favoriteCharacters: [Int]?
    
    func setEmail(_ email: String) -> UserDataRequestBuilder {
        self.email = email
        return self
    }
    
    func setImageUrl(_ imageUrl: String) -> UserDataRequestBuilder {
        self.imageUrl = imageUrl
        return self
    }
    
    func setFirstName(_ firstName: String) -> UserDataRequestBuilder {
        self.firstName = firstName
        return self
    }
    
    func setLastName(_ lastName: String) -> UserDataRequestBuilder {
        self.lastName = lastName
        return self
    }
    
    func setFavoriteLocations(_ favoriteLocations: [Int]) -> UserDataRequestBuilder {
        self.favoriteLocations = favoriteLocations
        return self
    }
    
    func setFavoriteCharacters(_ favoriteCharacters: [Int]) -> UserDataRequestBuilder {
        self.favoriteCharacters = favoriteCharacters
        return self
    }
    
    func build() -> [String: Any] {
        var array = [String: Any]()
        if let email = self.email {
            array.updateValue(email, forKey: FieldTitle.email.rawValue)
        }
        if let firstName = self.firstName {
            array.updateValue(firstName, forKey: FieldTitle.firstName.rawValue)
        }
        if let lastName = self.lastName {
            array.updateValue(lastName, forKey: FieldTitle.lastName.rawValue)
        }
        if let imageUrl = self.imageUrl {
            array.updateValue(imageUrl, forKey: FieldTitle.imageUrl.rawValue)
        }
        if let favoriteLocations = self.favoriteLocations {
            array.updateValue(favoriteLocations, forKey: FieldTitle.favoriteLocations.rawValue)
        }
        if let favoriteCharacters = self.favoriteCharacters {
            array.updateValue(favoriteCharacters, forKey: FieldTitle.favoriteCharacters.rawValue)
        }
        return array
    }
}
