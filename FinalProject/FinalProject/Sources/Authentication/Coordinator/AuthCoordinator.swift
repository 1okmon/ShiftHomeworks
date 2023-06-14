//
//  Coordinator.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import UIKit

final class AuthCoordinator: IAuthCoordinator {
    private weak var appCoordinator: AppCoordinator?
    private var navigationController: UINavigationController
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        goToSignIn()
    }
    
    func goToSignIn() {
        let signInViewController = AuthBuilder().setCoordinator(self).buildSignInViewController()
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func goToSignUp() {
        let signUpViewController = AuthBuilder().setCoordinator(self).buildSignUpViewController()
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToResetPassword() {
        let resetPasswordViewController = AuthBuilder().setCoordinator(self).buildResetPasswordViewController()
        self.navigationController.pushViewController(resetPasswordViewController, animated: true)
    }
    
    func signInConfirmed() {
        appCoordinator?.signInConfirmed()
    }
    
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }
}
