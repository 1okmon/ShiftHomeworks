//
//  Coordinator.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import UIKit

final class AuthCoordinator: IAuthCoordinator {
    private var appCoordinator: ISignedInAppCoordinator
    private var navigationController: UINavigationController
    init(navigationController: UINavigationController, appCoordinator: ISignedInAppCoordinator) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        goToSignIn()
    }
    
    func goToSignIn() {
        let signInViewController = AuthViewControllersFactory().setCoordinator(self).signInViewController()
        self.navigationController.viewControllers = [signInViewController]
    }
    
    func goToSignUp() {
        let signUpViewController = AuthViewControllersFactory().setCoordinator(self).signUpViewController()
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToResetPassword() {
        let resetPasswordViewController = AuthViewControllersFactory().setCoordinator(self).resetPasswordViewController()
        self.navigationController.pushViewController(resetPasswordViewController, animated: true)
    }
    
    func signInConfirmed() {
        appCoordinator.signInSuccess()
    }
    
    func goBackToSignIn() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
