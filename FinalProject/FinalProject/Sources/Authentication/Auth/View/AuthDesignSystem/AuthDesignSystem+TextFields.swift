//
//  AuthDesignSystem+TextFields.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    private enum Metrics {
        static let loginPlaceholder = "Введите E-mail"
        static let passwordPlaceholder = "Введите пароль"
        static let repeatPasswordPlaceholder = "Повторите пароль"
    }
    
    var loginTextField: UITextField {
        return self.textField(placeholderText: Metrics.loginPlaceholder)
    }
    
    var passwordTextField: UITextField {
        return self.textField(placeholderText: Metrics.passwordPlaceholder, isSecure: true)
    }
    
    var repeatPasswordTextField: UITextField {
        return self.textField(placeholderText: Metrics.repeatPasswordPlaceholder, isSecure: true)
    }
}
