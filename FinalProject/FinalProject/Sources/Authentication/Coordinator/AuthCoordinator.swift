//
//  Coordinator.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import UIKit

final class AuthCoordinator: IAuthCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSignIn()
    }
    
    func goToSignIn() {
        let viewModel = AuthViewModel(coordinator: self)
        let signInViewController = AuthViewControllerBuilder().setAuthType(.singIn).buildViewController(with: viewModel)
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func goToSignUp() {
        let viewModel = AuthViewModel(coordinator: self)
        let signUpViewController = AuthViewControllerBuilder().setAuthType(.signUp).buildViewController(with: viewModel)
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToResetPassword() {
        let viewModel = AuthViewModel(coordinator: self)
        let resetPasswordViewController = AuthViewControllerBuilder().setAuthType(.resetPassword).buildViewController(with: viewModel)
        self.navigationController.pushViewController(resetPasswordViewController, animated: true)
    }
}
