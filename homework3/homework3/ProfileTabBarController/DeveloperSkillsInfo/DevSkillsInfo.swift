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
    
    var begin: String {
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

struct DevSkillsInfo: GetAlexInfoProtocol {
    let experienceAge: Int
    let programmingLanguages: [String]
    let expectations: String
    
    private func endOfExperienceAge(experienceAge: Int) -> String {
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
    
    static func getAlexProfileInfo() -> DevSkillsInfo {
        return DevSkillsInfo(experienceAge: 21,
                             programmingLanguages: ["Swift", "C#", "Java", "PHP"],
                             expectations: "Приобрести/улучшить свои знания в iOS разработке. \nСтать частью команды ЦФТ😃")
    }
    
    func getExperienceAgeDescription() -> String {
        TitleInfo.experienceAge.begin + experienceAge.description + " " + endOfExperienceAge(experienceAge: experienceAge)
    }
    
    func getProgrammingLanguagesDescription() -> String {
        var text = TitleInfo.programmingLanguages.begin
        programmingLanguages.forEach {
            text += "\n\t" + $0
        }
        return text
    }
    
    func getExpectationsDescription() -> String {
        TitleInfo.expectations.begin + expectations
    }
}
