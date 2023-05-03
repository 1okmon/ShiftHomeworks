//
//  ProfileInfo.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation
import UIKit

fileprivate enum TitlePrefix {
    static let fio = "ФИО:\t"
    static let cityOfBirth = "Город рождения:\t"
    static let cityOfResidence = "Город проживания:\t"
    static let dateOfBirth = "Дата рождения: \t"
}

fileprivate enum DateMetrics {
    static let format = "dd.MM.yyyy"
}

struct ProfileInfo: MyInfoGenerator {
    var image: UIImage? = UIImage(systemName: "person.badge.plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    private let firstName: String
    private let lastName: String
    private let patronymic: String
    private var dateOfBirth: Date?
    private var cityOfBirth: String
    private let cityOfResidence: String
    
    var fullNameDescription: String {
        TitlePrefix.fio + "\(lastName) \(firstName) \(patronymic)"
    }
    
    var cityOfBirthDescription: String {
        TitlePrefix.cityOfBirth + "\(cityOfBirth)"
    }
    
    var cityOfResidenceDescription: String {
        TitlePrefix.cityOfResidence + "\(cityOfResidence)"
    }
    
    var dateOfBirthDescription:  String {
        let df = DateFormatter()
        df.dateFormat = DateMetrics.format
        guard let dateOfBirth = dateOfBirth else {
            return String()
        }
        return TitlePrefix.dateOfBirth + df.string(from: dateOfBirth)
    }
    
    static func myInfo() -> ProfileInfo {
        let dateOfBirth = DateComponents(year: 2000, month: 4, day: 4)
        return ProfileInfo(image: UIImage(named: "AlexProfilePhoto"),
                           firstName: "Алексей",
                           lastName: "Марьин",
                           patronymic: "Даниилович",
                           dateOfBirth: Calendar(identifier: .gregorian).date(from: dateOfBirth),
                           cityOfBirth: "Новокузнецк",
                           cityOfResidence: "Новосибирск")
    }
}
