//
//  CarBodyTypes.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

enum CarBodyType: Int, CaseIterable {
    case hatchback
    case stationWagon
    case pickup
    case van
    case minivan
    case sportsCar
    case phaeton
    case sedan
    case cabriolet
    case offRoadCar
    case roadster
    case limousine
    case coupe
    case crossover
    
    var representedValue: String {
        let num = "\n\t" + String(self.rawValue + 1) + ".\t"
        switch self {
        case .hatchback:
            return num + "Хэтчбек"
        case .stationWagon:
            return num + "Универсал"
        case .pickup:
            return num + "Пикап"
        case .van :
            return num + "Фургон"
        case .minivan:
            return num + "Минивэн"
        case .sportsCar:
            return num + "Спортивный автомобиль"
        case .phaeton:
            return num + "Фаэтон"
        case .sedan:
            return num + "Седан"
        case .cabriolet:
            return num + "Кабриолет"
        case .offRoadCar:
            return num + "Внедорожник"
        case .roadster:
            return num + "Родстер"
        case .limousine:
            return num + "Лимузин"
        case .coupe:
            return num + "Купе"
        case .crossover:
            return num + "Кроссовер"
        }
    }
}
