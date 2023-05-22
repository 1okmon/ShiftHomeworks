//
//  AuthViewBuilder.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 17.05.2023.
//

import UIKit

final class AuthViewControllerBuilder {
    private var authType: AuthType?
    
    func setAuthType(_ authType: AuthType) -> AuthViewControllerBuilder {
        self.authType = authType
        return self
    }
    
    func buildViewController(with viewModel: IAuthViewModel) -> AuthViewController {
        return AuthViewController(authView: self.buildAuthView(with: viewModel),
                                  authViewModel: viewModel)
    }
}

private extension AuthViewControllerBuilder {
    func buildAuthView(with viewModel: IAuthViewModel) -> AuthView {
        guard let authType = authType else {
            fatalError("Authentication type is empty!")
        }
        switch authType {
        case .signUp:
            return buildSignUpView(with: viewModel)
        case .singIn:
            return buildSignInView(with: viewModel)
        case .resetPassword:
            return buildResetPasswordView(with: viewModel)
        }
    }
    
    func buildSignUpView(with viewModel: IAuthViewModel) -> AuthView {
        AuthView(titleLabel: AuthDesignSystem.Labels.signUp.label,
                 textFields: [AuthDesignSystem.TextFields.login.textField,
                              AuthDesignSystem.TextFields.password.textField,
                              AuthDesignSystem.TextFields.repeatPassword.textField],
                 buttons: [AuthDesignSystem.Buttons.submitSignUp.button(
                            with: { viewModel.submitSignUp() }
                 )])
    }
    
    func buildSignInView(with viewModel: IAuthViewModel) -> AuthView {
        AuthView(titleLabel: AuthDesignSystem.Labels.signIn.label,
                 textFields: [AuthDesignSystem.TextFields.login.textField,
                              AuthDesignSystem.TextFields.password.textField],
                 buttons: [AuthDesignSystem.Buttons.signIn.button(
                            with: { viewModel.signIn() }),
                           AuthDesignSystem.Buttons.signUp.button(
                            with: { viewModel.signUp() }),
                           AuthDesignSystem.Buttons.resetPassword.button(
                            with: { viewModel.resetPassword() })])
    }
    
    func buildResetPasswordView(with viewModel: IAuthViewModel) -> AuthView {
        AuthView(titleLabel: AuthDesignSystem.Labels.resetPassword.label,
                 textFields: [AuthDesignSystem.TextFields.login.textField],
                 buttons: [AuthDesignSystem.Buttons.submitResetPassword.button(
                            with: { viewModel.submitResetPassword() })])
    }
}
