//
//  AuthDesignSystem+Labels.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

extension AuthDesignSystem {
    private enum Metrics {
        static let signInText = "Вход"
        static let signUpText = "Регистрация"
        static let resetPasswordText = "Сброс пароля"
    }
    
    var signInTitleLabel: UILabel {
        return self.label(text: Metrics.signInText)
    }
    
    var signUpTitleLabel: UILabel {
        return self.label(text: Metrics.signUpText)
    }
    
    var resetPasswordTitleLabel: UILabel {
        return self.label(text: Metrics.resetPasswordText)
    }
}
