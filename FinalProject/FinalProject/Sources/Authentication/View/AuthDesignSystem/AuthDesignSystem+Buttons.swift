//
//  AuthDesignSystem+Buttons.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    enum Buttons {
        case signIn
        case signUp
        case submitSignUp
        case resetPassword
        case submitResetPassword
        
        func button(with action:(()->Void)?) -> AuthButtonDecorator {
            let designSystem = AuthDesignSystem()
            switch self {
            case .signIn:
                return designSystem.button(text: Metrics.signInText, buttonType: .signIn, with: action)
            case .signUp:
                return designSystem.button(text: Metrics.signUpText, buttonType: .signUp, with: action)
            case .submitSignUp:
                return designSystem.button(text: Metrics.submitSignUpText, buttonType: .submitSignUp, with: action)
            case .resetPassword:
                return designSystem.forgotPasswordButton(text: Metrics.resetPasswordText, buttonType: .resetPassword, with: action)
            case .submitResetPassword:
                return designSystem.button(text: Metrics.submitResetPasswordText, buttonType: .submitResetPassword, with: action)
            }
        }
        
        private enum Metrics {
            static let signInText = "Войти"
            static let signUpText = "Зарегистрироваться"
            static let submitSignUpText = "Создать учетную запись"
            static let resetPasswordText = "Забыли пароль?"
            static let submitResetPasswordText = "Отправить письмо"
        }
    }
}
