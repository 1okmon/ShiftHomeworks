//
//  ResetPasswordView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class ResetPasswordView: AuthView {
    var submitResetPasswordTapHandler: ((String?) -> Void)?
    private let titleLabel: UILabel
    private let emailTextField: UITextField
    private let submitResetPasswordButton: UIButton
    
    init() {
        let authDesignSystem = AuthDesignSystem()
        self.titleLabel = authDesignSystem.resetPasswordTitleLabel
        self.emailTextField = authDesignSystem.loginTextField
        self.submitResetPasswordButton = authDesignSystem.submitResetPasswordButton
        super.init(titleLabel: titleLabel,
                   textFields: [emailTextField],
                   buttons: [submitResetPasswordButton])
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ResetPasswordView {
    func configure() {
        submitResetPasswordButton.addTarget(self, action: #selector(submitResetPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc func submitResetPasswordButtonTapped() {
        guard let handler = submitResetPasswordTapHandler else { return }
        handler(emailTextField.text)
    }
}
