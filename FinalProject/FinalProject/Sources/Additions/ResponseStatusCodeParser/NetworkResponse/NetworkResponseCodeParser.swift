//
//  NetworkResponseCodeParser.swift
//  FinalProject
//
//  Created by 1okmon on 09.06.2023.
//

import Foundation
final class NetworkResponseCodeParser {
    func parse(error: Error) -> IAlertRepresentable {
        guard let error = error as? URLError else {
            return NetworkResponseCode.unknown
        }
        switch error.code {
        case .timedOut:
            return NetworkResponseCode.timedOut
        case .networkConnectionLost:
            return NetworkResponseCode.networkConnectionLost
        case .notConnectedToInternet:
            return NetworkResponseCode.notConnectedToInternet
        default:
            return NetworkResponseCode.unknown
        }
    }
}
