//
//  SignUpView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
final class SignUpView: AuthView {
    var submitSignUpTapHandler: ((String, String) -> Void)?
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
        super.init(titleLabel: titleLabel,
                   textFields: [emailTextField, passwordTextField, repeatPasswordTextField],
                   buttons: [submitSignUpButton])
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpView {
    func configure() {
        submitSignUpButton.addTarget(self, action: #selector(submitSignUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func submitSignUpButtonTapped() {
        guard let handler = submitSignUpTapHandler else { return }
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let repeatPassword = repeatPasswordTextField.text else { return }
        guard repeatPassword == password else { return }
        showActivityIndicatory()
        handler(email, password)
    }
}
