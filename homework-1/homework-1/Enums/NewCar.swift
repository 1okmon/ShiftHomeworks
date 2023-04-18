//
//  NewCar.swift
//  homework-1
//
//  Created by 1okmon on 13.04.2023.
//

import Foundation

enum NewCar {
    case manufacturer
    case model
    case body
    case yearOfIssue
    case carNumber
    
    var carPartEnterCommand: String {
        switch self {
        case .manufacturer:
            return "Введите название марки автомобиля:"
        case .model:
            return "Введите название модели автомобиля:"
        case .body:
            return "Выберете кузов автомобиля:"
        case .yearOfIssue:
            return "Введите год выпуска автомобиля или нажмите Enter, чтобы пропустить это поле:"
        case .carNumber:
            return "Введите гос. номер автомобиля или нажмите Enter, чтобы пропустить это поле:"
        }
    }
    
    var wrongInput: String {
        switch self {
        case .manufacturer:
            return "Вы не заполнили обязательное поле (производитель), пожалуйста, повторите попытку:"
        case .model:
            return "Вы не заполнили обязательное поле (модель), пожалуйста, повторите попытку:"
        case .yearOfIssue:
            return "Вы введеном вами году еще не было произведено машин, пожалуйста, повторите попытку:"
        default:
            return String()
        }
    }
}
