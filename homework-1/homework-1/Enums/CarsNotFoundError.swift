//
//  CarsNotFound.swift
//  homework-1
//
//  Created by 1okmon on 13.04.2023.
//

import Foundation

enum CarsNotFoundError: Error {
    case noCarAtAll
    case noCarWithBodyFilter
}

extension CarsNotFoundError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noCarAtAll:
            return NSLocalizedString("Автомобили не найдейны!", comment: String())
        case .noCarWithBodyFilter:
            return NSLocalizedString("Автомобили с данным типом кузова не найдейны!", comment: String())
        }
    }
}
