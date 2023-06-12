//
//  ResponseErrorCode.swift
//  FinalProject
//
//  Created by 1okmon on 09.06.2023.
//

import Foundation
enum ResponseErrorCode: IAlertRepresentable {
    case timedOut
    case networkConnectionLost
    case notConnectedToInternet
    case unknown
    
    var title: String {
        switch self {
        case .timedOut:
            return "Время ожидания запроса истекло"
        case .networkConnectionLost:
            return "Потеряно сетевое подключение"
        case.notConnectedToInternet:
            return "Подключение к сети отсутствует"
        case .unknown:
            return "При загрузке произошла непредвиденная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .timedOut, .notConnectedToInternet:
            return "Пожалуйста, проверьте интернет подключение"
        case .networkConnectionLost:
            return "Повторите попытку позднее"
        case .unknown:
            return "Мы уже работаем над ее исправлением"
        }
    }
    
    var buttonTitle: String {
        return "ОК"
    }
}
