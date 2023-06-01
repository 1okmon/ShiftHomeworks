//
//  CharacterGender.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import Foundation

enum CharacterGender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown
    
    var representedValue: String {
        switch self {
        case .female:
            return "Женский"
        case .male:
            return "Мужской"
        case .genderless:
            return "Бесполый"
        case .unknown:
            return "Неизвестно"
        }
    }
}
