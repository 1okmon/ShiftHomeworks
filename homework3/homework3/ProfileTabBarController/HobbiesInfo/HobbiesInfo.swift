//
//  HobbiesInfo.swift
//  homework3
//
//  Created by 1okmon on 27.04.2023.
//

import Foundation

struct HobbiesInfo: MyInfoGenerator {
    private let hobbies: [String]
    
    var randomHobbyDescription: String {
        guard !hobbies.isEmpty else {
            return String()
        }
        let randomHobbyId = Int.random(in: 0 ..< hobbies.count)
        return hobbies[randomHobbyId]
    }
    
    var allHobbiesDescription: String {
        var text = "Увлечения:"
        hobbies.forEach {
            text += "\n\t" + $0
        }
        return text
    }
    
    static func myInfo() -> HobbiesInfo {
        return HobbiesInfo(hobbies: ["Cборка ПК 🖥️", "Горные лыжи ⛷️", "Видеоигры 🎮", "Музыка 🎧", "Монтаж Видео 🎥"])
    }
}
