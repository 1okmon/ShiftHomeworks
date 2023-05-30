//
//  ErrorParser.swift
//  FinalProject
//
//  Created by 1okmon on 26.05.2023.
//

import Firebase
final class ErrorParser {
    func parse(error: Error) -> AuthResult {
        if let errCode = AuthErrorCode.Code(rawValue: error._code) {
            switch errCode {
            case .wrongPassword:
                return .wrongPassword
            case .userNotFound:
                return .userNotFound
            case .weakPassword:
                return .weakPassword
            case .emailAlreadyInUse:
                return .emailAlreadyInUse
            case .networkError:
                return .networkError
            case .internalError:
                return .serverError
            case .tooManyRequests:
                return .tooManyRequests
            case .invalidEmail:
                return .badEmailFormat
            default:
                return .undefinedError
            }
        }
        return .undefinedError
    }
}
