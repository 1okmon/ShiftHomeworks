//
//  AuthDesignSystem+Buttons.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    fileprivate enum Metrics {
        static let signInText = "Войти"
        static let signUpText = "Зарегистрироваться"
        static let submitSignUpText = "Создать учетную запись"
        static let resetPasswordText = "Забыли пароль?"
        static let submitResetPasswordText = "Отправить письмо"
    }
    
    var signInButton: UIButton {
        return self.button(with: Metrics.signInText)
    }
    
    var signUpButton: UIButton {
        return self.button(with: Metrics.signUpText)
    }
    
    var submitSignUpButton: UIButton {
        return self.button(with: Metrics.submitSignUpText)
    }
    
    var resetPasswordButton: UIButton {
        return self.forgotPasswordButton(with: Metrics.resetPasswordText)
    }
    
    var submitResetPasswordButton: UIButton {
        return self.button(with: Metrics.submitResetPasswordText)
    } 
}
