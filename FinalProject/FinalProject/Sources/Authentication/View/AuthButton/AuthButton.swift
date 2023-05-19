//
//  AuthButton.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import UIKit

enum AuthButtonType {
    case signIn
    case signUp
    case submitSignUp
    case resetPassword
    case submitResetPassword
    
    func button(button: AuthButton, with action:(()->Void)?) -> AuthButtonDecorator {
        switch self {
        case .signIn:
            return SignInButton(decorator: button, action: action)
        case .signUp:
            return SignUpButton(decorator: button, action: action)
        case .submitSignUp:
            return SubmitSignUpButton(decorator: button, action: action)
        case .resetPassword:
            return ResetPasswordButton(decorator: button, action: action)
        case .submitResetPassword:
            return SubmitResetPasswordButton(decorator: button, action: action)
        }
    }
}

final class AuthButton: UIButton, IAuthButton {
    @objc func didTapped() {}
}
