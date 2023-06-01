//
//  CharacterStatus.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import Foundation

enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    var representedValue: String {
        switch self {
        case .alive:
            return "Живой"
        case .dead:
            return "Мертвый"
        case .unknown:
            return "Неизвестно"
        }
    }
}
