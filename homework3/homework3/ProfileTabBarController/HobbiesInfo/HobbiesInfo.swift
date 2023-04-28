//
//  HobbiesInfo.swift
//  homework3
//
//  Created by 1okmon on 27.04.2023.
//

import Foundation

struct HobbiesInfo: GetAlexInfoProtocol {
    let hobbies: [String]
    
    static func getAlexProfileInfo() -> HobbiesInfo {
        return HobbiesInfo(hobbies: ["Cборка ПК 🖥️", "Горные лыжи ⛷️", "Видеоигры 🎮", "Музыка 🎧", "Монтаж Видео 🎥"])
    }
    
    func getRandomHobbieAsText() -> String {
        guard !hobbies.isEmpty else {
            return String()
        }
        let randomHobbieId = Int.random(in: 0 ..< hobbies.count)
        return hobbies[randomHobbieId]
    }
    
    func getAllHobbiesAsText() -> String {
        var text = "Увлечения:"
        hobbies.forEach {
            text += "\n\t" + $0
        }
        return text
    }
}
