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
    
    var representedValue: String {
        var text: String
        switch self {
        case .hello:
            text = "Вас приветствует программа для учета автомобилей!"
            return text
        case .userActions:
            text = "Выберете пункт:"
            for action in UserAction.allCases {
                text = text + action.representedValue
            }
            return text
        case .carBodies:
            text = "Выберете кузов:"
            for body in CarBodyType.allCases {
                text = text + body.representedValue
            }
            return text
        case .allert:
            text = "Выбранный вами пункт отсутствует! Пожалуйста повторите попытку:"
            return text
        }
    }
}
