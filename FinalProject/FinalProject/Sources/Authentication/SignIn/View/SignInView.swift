//
//  SignInView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
final class SignInView: AuthView {
    var signInTapHandler: ((String, String) -> Void)?
    var signUpTapHandler: (() -> Void)?
    var resetPasswordTapHandler: (() -> Void)?
    private let titleLabel: UILabel
    private let emailTextField: UITextField
    private let passwordTextField: UITextField
    private let signInButton: UIButton
    private let signUpButton: UIButton
    private let resetPasswordButton: UIButton
    
    init() {
        let authDesignSystem = AuthDesignSystem()
        self.titleLabel = authDesignSystem.signInTitleLabel
        self.emailTextField = authDesignSystem.loginTextField
        self.passwordTextField = authDesignSystem.passwordTextField
        self.signInButton = authDesignSystem.signInButton
        self.signUpButton = authDesignSystem.signUpButton
        self.resetPasswordButton = authDesignSystem.resetPasswordButton
        super.init(titleLabel: titleLabel,
                   textFields: [emailTextField, passwordTextField],
                   buttons: [signInButton, signUpButton, resetPasswordButton])
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showResetPasswordButton() {
        UIView.animate(withDuration: 0.5) {
            self.resetPasswordButton.isHidden = false
        }
    }
}

private extension SignInView {
    func configure() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUnButtonTapped), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        resetPasswordButton.isHidden = true
    }
    
    @objc func signInButtonTapped() {
        guard let handler = signInTapHandler else { return }
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(of: .fieldsNotFilled)
            return
        }
        showActivityIndicatory()
        handler(email, password)
    }
    
    @objc func signUnButtonTapped() {
        guard let handler = signUpTapHandler else { return }
        handler()
    }
    
    @objc func resetPasswordButtonTapped() {
        guard let handler = resetPasswordTapHandler else { return }
        handler()
    }
}
