//
//  AuthViewBuilder.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 17.05.2023.
//

import UIKit

final class AuthBuilder {
    private var coordinator: AuthCoordinator?
    private var viewModel: AuthViewModel {
        guard let coordinator = self.coordinator else {
            fatalError("Coordinator should not be nil")
        }
        return AuthViewModel(coordinator: coordinator,
                             firebaseNetworkManager: FirebaseNetworkManager())
    }
    
    func setCoordinator(_ coordinator: AuthCoordinator) -> AuthBuilder {
        self.coordinator = coordinator
        return self
    }
    
    func buildSignInViewController() -> SignInViewController {
        let viewModel = viewModel
        let signInViewController = SignInViewController(signInView: SignInView(), signInViewModel: viewModel)
        viewModel.subscribe(observer: signInViewController)
        return signInViewController
    }
    
    func buildSignUpViewController() -> SignUpViewController {
        let viewModel = viewModel
        let signUpViewController = SignUpViewController(signUpView: SignUpView(), signUpViewModel: viewModel)
        viewModel.subscribe(observer: signUpViewController)
        return signUpViewController
    }
    
    func buildResetPasswordViewController() -> ResetPasswordViewController {
        let viewModel = viewModel
        let resetPasswordViewController = ResetPasswordViewController(resetPasswordView: ResetPasswordView(), resetPasswordViewModel: viewModel)
        viewModel.subscribe(observer: resetPasswordViewController)
        return resetPasswordViewController
    }
}
