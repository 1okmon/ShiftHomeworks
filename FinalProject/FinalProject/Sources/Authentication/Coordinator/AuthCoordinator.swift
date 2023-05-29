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
        let signInViewController = AuthViewControllerBuilder().setAuthType(.singIn).setViewModel(viewModel).build()
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func goToSignUp() {
        let viewModel = AuthViewModel(coordinator: self)
        let signUpViewController = AuthViewControllerBuilder().setAuthType(.signUp).setViewModel(viewModel).build()
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToResetPassword() {
        let viewModel = AuthViewModel(coordinator: self)
        let resetPasswordViewController = AuthViewControllerBuilder().setAuthType(.resetPassword).setViewModel(viewModel).build()
        self.navigationController.pushViewController(resetPasswordViewController, animated: true)
    }
}
