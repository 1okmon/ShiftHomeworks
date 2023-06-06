//
//  AuthDesignSystem+Labels.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    enum Labels {
        case signIn
        case signUp
        case resetPassword

        var label: UILabel {
            let designSystem = AuthDesignSystem()
            switch self {
            case .signIn:
                return designSystem.label(text: Metrics.signInText)
            case .signUp:
                return designSystem.label(text: Metrics.signUpText)
            case .resetPassword:
                return designSystem.label(text: Metrics.resetPasswordText)
            }
        }
        
        private enum Metrics {
            static let signInText = "Авторизация"
            static let signUpText = "Регистрация"
            static let resetPasswordText = "Сброс пароля"
        }
    }
}
