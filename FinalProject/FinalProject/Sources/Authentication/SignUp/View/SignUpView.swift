//
//  SignUpView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class SignUpView: AuthView {
    var submitSignUpTapHandler: ((String, String, String) -> Void)?
    private let titleLabel: UILabel
    private let emailTextField: UITextField
    private let passwordTextField: UITextField
    private let repeatPasswordTextField: UITextField
    private let submitSignUpButton: UIButton
    
    init() {
        let authDesignSystem = AuthDesignSystem()
        self.titleLabel = authDesignSystem.signUpTitleLabel
        self.emailTextField = authDesignSystem.loginTextField
        self.passwordTextField = authDesignSystem.passwordTextField
        self.repeatPasswordTextField = authDesignSystem.repeatPasswordTextField
        self.submitSignUpButton = authDesignSystem.submitSignUpButton
        super.init(titleLabel: self.titleLabel,
                   textFields: [self.emailTextField,
                                self.passwordTextField,
                                self.repeatPasswordTextField],
                   buttons: [self.submitSignUpButton])
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpView {
    func configure() {
        self.submitSignUpButton.addTarget(self, action: #selector(self.submitSignUpButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func submitSignUpButtonTapped(_ sender: UIButton) {
        guard let handler = self.submitSignUpTapHandler,
              let email = self.emailTextField.text,
              let password = self.passwordTextField.text,
              let repeatPassword = self.repeatPasswordTextField.text else {
            return
        }
        handler(email, password, repeatPassword)
    }
}
