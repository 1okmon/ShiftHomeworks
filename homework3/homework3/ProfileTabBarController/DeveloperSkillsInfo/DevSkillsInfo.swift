//
//  DevSkillsInfo.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation

fileprivate enum TitleInfo {
    case experienceAge
    case programmingLanguages
    case expectations
    
    var prefix: String {
        switch self {
        case .experienceAge:
            return "В программировании "
        case .programmingLanguages:
            return "Опыт программирования на языках:"
        case .expectations:
            return "Ожидания: "
        }
    }
}

fileprivate enum ExperienceAgeLimit {
    static let min = 0
    static let max = 100
}

struct DevSkillsInfo: MyInfoGenerator {
    private let experienceAge: Int
    private let programmingLanguages: [String]
    private let expectations: String
    
    private func postfixOfExperienceAge(experienceAge: Int) -> String {
        guard experienceAge > ExperienceAgeLimit.min,
              experienceAge < ExperienceAgeLimit.max else { return String() }
        let decadeDigit:Int = (experienceAge % 100) / 10
        guard decadeDigit != 1 else { return "лет" }
        switch experienceAge % 10 {
        case 0:
            return "лет"
        case 1:
            return "год"
        case 2...4:
            return "года"
        case 4 ..< 9:
            return "лет"
        default:
            return String()
        }
    }
    
    static func myInfo() -> DevSkillsInfo {
        return DevSkillsInfo(experienceAge: 21,
                             programmingLanguages: ["Swift", "C#", "Java", "PHP"],
                             expectations: "Приобрести/улучшить свои знания в iOS разработке. \nСтать частью команды ЦФТ😃")
    }
    
    var experienceAgeDescription: String {
        TitleInfo.experienceAge.prefix + experienceAge.description + " " + postfixOfExperienceAge(experienceAge: experienceAge)
    }
    
    var programmingLanguagesDescription: String {
        var text = TitleInfo.programmingLanguages.prefix
        programmingLanguages.forEach {
            text += "\n\t" + $0
        }
        return text
    }
    
    var expectationsDescription: String {
        TitleInfo.expectations.prefix + expectations
    }
}
