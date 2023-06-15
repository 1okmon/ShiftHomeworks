//
//  ErrorParser.swift
//  FinalProject
//
//  Created by 1okmon on 26.05.2023.
//

import Firebase

final class AuthResponseParser {
    func parse(error: Error) -> IAlertRepresentable {
        if let error = error as? URLError {
            return NetworkResponseCodeParser().parse(error: error)
        }
        guard let responseCode = AuthErrorCode.Code(rawValue: error._code) else {
            return AuthResult.undefinedError
        }
        switch responseCode {
        case .wrongPassword:
            return AuthResult.wrongPassword
        case .userNotFound:
            return AuthResult.userNotFound
        case .weakPassword:
            return AuthResult.weakPassword
        case .emailAlreadyInUse:
            return AuthResult.emailAlreadyInUse
        case .networkError:
            return AuthResult.networkError
        case .internalError:
            return AuthResult.serverError
        case .tooManyRequests:
            return AuthResult.tooManyRequests
        case .invalidEmail:
            return AuthResult.badEmailFormat
        default:
            return AuthResult.undefinedError
        }
    }
}
