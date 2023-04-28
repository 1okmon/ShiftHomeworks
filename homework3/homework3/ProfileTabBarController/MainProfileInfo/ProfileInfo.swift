//
//  ProfileInfo.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation
import UIKit

fileprivate enum TitleInfo {
    static let fio = "ФИО:\t"
    static let cityOfBirth = "Город рождения:\t"
    static let cityOfResidence = "Город проживания:\t"
    static let dateOfBirth = "Дата рождения: \t"
    static let dateFormat = "dd.MM.yyyy"
}

struct ProfileInfo: GetAlexInfoProtocol {
    var image: UIImage? = UIImage(systemName: "person.badge.plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let firstName: String
    let lastName: String
    let patronym: String
    var dateOfBirth: Date?
    var cityOfBirth: String
    let cityOfResidence: String
    
    static func getAlexProfileInfo() -> ProfileInfo {
        let dateOfBirth = DateComponents(year: 2000, month: 4, day: 4)
        return ProfileInfo(image: UIImage(named: "AlexProfilePhoto"),
                           firstName: "Алексей",
                           lastName: "Марьин",
                           patronym: "Даниилович",
                           dateOfBirth: Calendar(identifier: .gregorian).date(from: dateOfBirth),
                           cityOfBirth: "Новокузнецк",
                           cityOfResidence: "Новосибирск")
    }
    
    func getFullName() -> String {
        TitleInfo.fio + "\(lastName) \(firstName) \(patronym)"
    }
    
    func getCityOfBirth() -> String {
        TitleInfo.cityOfBirth + "\(cityOfBirth)"
    }
    
    func getCityOfResidence() -> String {
        TitleInfo.cityOfResidence + "\(cityOfResidence)"
    }
    
    func getDateOfBirth() -> String {
        let df = DateFormatter()
        df.dateFormat = TitleInfo.dateFormat
        guard let dateOfBirth = dateOfBirth else {
            return String()
        }
        return TitleInfo.dateOfBirth + df.string(from: dateOfBirth)
    }
}
