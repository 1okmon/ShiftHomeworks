//
//  AuthViewBuilder.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 17.05.2023.
//

import UIKit

private enum Metrics {
    enum FatalError{
        static let emptyViewModelText = "ViewModel is empty!"
        static let emptyAuthTypeText = "Authentication type is empty!"
    }
}

final class AuthViewControllerBuilder {
    private var authType: AuthType?
    private var viewModel: IAuthViewModel?
    
    func setAuthType(_ authType: AuthType) -> AuthViewControllerBuilder {
        self.authType = authType
        return self
    }
    
    func setViewModel(_ viewModel: IAuthViewModel?) -> AuthViewControllerBuilder {
        self.viewModel = viewModel
        return self
    }
    
    func build() -> AuthViewController {
        guard let viewModel = self.viewModel else {
            fatalError(Metrics.FatalError.emptyViewModelText)
        }
        return AuthViewController(authView: self.buildAuthView(with: viewModel),
                                  authViewModel: viewModel)
    }
}

private extension AuthViewControllerBuilder {
    func buildAuthView(with viewModel: IAuthViewModel) -> AuthView {
        guard let authType = authType else {
            fatalError(Metrics.FatalError.emptyAuthTypeText)
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
