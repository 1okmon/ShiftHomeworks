//
//  InterfaceMessage.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

enum InterfaceMessage: Int {
    case hello
    case userActions
    case carBodies
    case allert
    
    private var text: String {
        switch self {
        case .hello:
            return "Вас приветствует программа для учета автомобилей!"
        case .userActions:
            return "Выберете пункт:"
        case .carBodies:
            return "Выберете кузов:"
        case .allert:
            return "Выбранный вами пункт отсутствует! Пожалуйста повторите попытку:"
        }
    }
    
    var representedValue: String {
        switch self {
        case .hello:
            return text
        case .userActions:
            var actions = String()
            UserAction.allCases.forEach { actions += $0.representedValue }
            return text + actions
        case .carBodies:
            var carBodies = String()
            CarBodyType.allCases.forEach { carBodies += $0.representedValue }
            return text + carBodies
        case .allert:
            return text
        }
    }
}
