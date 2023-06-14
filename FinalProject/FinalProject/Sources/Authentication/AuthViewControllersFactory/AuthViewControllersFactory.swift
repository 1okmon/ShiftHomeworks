//
//  AuthViewControllersFactory.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 17.05.2023.
//

import UIKit

final class AuthViewControllersFactory {
    private var coordinator: AuthCoordinator?
    private var viewModel: AuthViewModel {
        guard let coordinator = self.coordinator else {
            fatalError("Coordinator should not be nil")
        }
        return AuthViewModel(coordinator: coordinator,
                             firebaseNetworkManager: FirebaseNetworkManager())
    }
    
    func setCoordinator(_ coordinator: AuthCoordinator) -> AuthViewControllersFactory {
        self.coordinator = coordinator
        return self
    }
    
    func signInViewController() -> SignInViewController {
        let viewModel = self.viewModel
        let signInViewController = SignInViewController(signInView: SignInView(), signInViewModel: viewModel)
        viewModel.subscribe(observer: signInViewController)
        return signInViewController
    }
    
    func signUpViewController() -> SignUpViewController {
        let viewModel = self.viewModel
        let signUpViewController = SignUpViewController(signUpView: SignUpView(), signUpViewModel: viewModel)
        viewModel.subscribe(observer: signUpViewController)
        return signUpViewController
    }
    
    func resetPasswordViewController() -> ResetPasswordViewController {
        let viewModel = self.viewModel
        let resetPasswordViewController = ResetPasswordViewController(resetPasswordView: ResetPasswordView(), resetPasswordViewModel: viewModel)
        viewModel.subscribe(observer: resetPasswordViewController)
        return resetPasswordViewController
    }
}
