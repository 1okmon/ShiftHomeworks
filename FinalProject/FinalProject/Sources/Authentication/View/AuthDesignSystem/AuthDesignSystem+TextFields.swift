//
//  AuthDesignSystem+TextFields.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    enum TextFields {
        case login
        case password
        case repeatPassword
        
        var textField: UITextField {
            let designSystem = AuthDesignSystem()
            switch self {
            case .login:
                return designSystem.textField(placeholder: Metrics.loginPlaceholder)
            case .password:
                return designSystem.textField(placeholder: Metrics.passwordPlaceholder)
            case .repeatPassword:
                return designSystem.textField(placeholder: Metrics.repeatPasswordPlaceholder)
            }
        }
        
        private enum Metrics {
            static let loginPlaceholder = "Введите E-mail"
            static let passwordPlaceholder = "Введите пароль"
            static let repeatPasswordPlaceholder = "Повторите пароль"
        }
        
    }
}
