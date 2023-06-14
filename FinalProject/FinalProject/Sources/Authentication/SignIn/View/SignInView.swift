//
//  SignInView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
private enum Metrics {
    static let animationDuration = 0.5
}

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
        super.init(titleLabel: self.titleLabel,
                   textFields: [self.emailTextField,
                                self.passwordTextField],
                   buttons: [self.signInButton,
                             self.signUpButton,
                             self.resetPasswordButton])
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with userSignInDetails: UserSignInDetails) {
        self.showActivityIndicator()
        self.emailTextField.text = userSignInDetails.email
        self.passwordTextField.text = userSignInDetails.password
    }
    
    func showResetPasswordButton() {
        UIView.animate(withDuration: Metrics.animationDuration) {
            self.resetPasswordButton.isHidden = false
        }
    }
}

private extension SignInView {
    func configure() {
        self.signInButton.addTarget(self, action: #selector(self.signInButtonTapped(_:)), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(self.signUnButtonTapped(_:)), for: .touchUpInside)
        self.resetPasswordButton.addTarget(self, action: #selector(self.resetPasswordButtonTapped(_:)), for: .touchUpInside)
        self.resetPasswordButton.isHidden = true
    }
    
    @objc func signInButtonTapped(_ sender: UIButton) {
        guard let handler = self.signInTapHandler else { return }
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text else {
            return
        }
        handler(email, password)
    }
    
    @objc func signUnButtonTapped(_ sender: UIButton) {
        guard let handler = self.signUpTapHandler else { return }
        handler()
    }
    
    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        guard let handler = self.resetPasswordTapHandler else { return }
        handler()
    }
}
