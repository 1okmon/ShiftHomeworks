//
//  ResponseErrorCodeParser.swift
//  FinalProject
//
//  Created by 1okmon on 09.06.2023.
//

import Foundation
final class ResponseErrorCodeParser {
    func parse(error: Error) -> IAlertRepresentable {
        guard let error = error as? URLError else {
            return ResponseErrorCode.unknown
        }
        switch error.code {
        case .timedOut:
            return ResponseErrorCode.timedOut
        case .networkConnectionLost:
            return ResponseErrorCode.networkConnectionLost
        case .notConnectedToInternet:
            return ResponseErrorCode.notConnectedToInternet
        default:
            return ResponseErrorCode.unknown
        }
    }
}
