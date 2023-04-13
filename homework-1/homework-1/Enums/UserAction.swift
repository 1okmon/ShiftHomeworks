//
//  Actions.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

enum UserAction: Int, CaseIterable {
    case addNew
    case printAll
    case printWithFilterByBody
    case exit
    
    var representedValue: String {
        let num = "\n\t" + String(self.rawValue + 1) + ".\t"
        switch self {
        case .addNew:
            return num + "Добавление нового автомобиля"
        case .printAll:
            return num + "Вывод списка добавленных автомобилей"
        case .printWithFilterByBody:
            return num + "Вывод списка автомобилей с использованием фильтра по типу кузова автомобиля"
        case .exit:
            return num + "Завершение работы"
        }
    }
    
    static func callAction(id: Int) {
        let chosen = UserAction(rawValue: id)
        switch chosen {
        case .addNew:
            Actions.addNewCar()
        case .printAll:
            Actions.printAllCars()
        case .printWithFilterByBody:
            let bodyId = Actions.askForAction(output: InterfaceMessage.carBodies.representedValue, upperBound: CarBodyType.allCases.count)
            guard let bodyId = bodyId, let body = CarBodyType(rawValue: bodyId) else {
                return
            }
            Actions.printCarsByBody(bodyType: body)
        case .exit:
            print("Выключение...")
            Darwin.exit(0)
        case .none:
            return
        }
    }
}
