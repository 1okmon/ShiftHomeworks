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
        return AuthViewController(authView: self.buildAuthView(viewModel: viewModel),
                                  authViewModel: viewModel)
    }
}

private extension AuthViewControllerBuilder {
    func buildAuthView(viewModel: IAuthViewModel) -> AuthView {
        guard let authType = authType else {
            fatalError("Authentication type is empty!")
        }
        switch authType {
        case .signUp:
            return buildSignUpView(viewModel: viewModel)
        case .singIn:
            return buildSignInView(viewModel: viewModel)
        case .resetPassword:
            return buildResetPasswordView(viewModel: viewModel)
        }
    }
    
    func buildSignUpView(viewModel: IAuthViewModel) -> AuthView {
        AuthView(titleLabel: AuthDesignSystem.Labels.signUp.label,
                 textFields: [AuthDesignSystem.TextFields.login.textField,
                              AuthDesignSystem.TextFields.password.textField,
                              AuthDesignSystem.TextFields.repeatPassword.textField],
                 buttons: [AuthDesignSystem.Buttons.submitSignUp.button(
                            with: { viewModel.submitSignUp() }
                 )])
    }
    
    func buildSignInView(viewModel: IAuthViewModel) -> AuthView {
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
    
    func buildResetPasswordView(viewModel: IAuthViewModel) -> AuthView {
        AuthView(titleLabel: AuthDesignSystem.Labels.resetPassword.label,
                 textFields: [AuthDesignSystem.TextFields.login.textField],
                 buttons: [AuthDesignSystem.Buttons.submitResetPassword.button(
                            with: { viewModel.submitResetPassword() })])
    }
}
