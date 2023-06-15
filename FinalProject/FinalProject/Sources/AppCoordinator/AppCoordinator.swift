//
//  AppCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
import Firebase

final class AppCoordinator: ISignInAppCoordinator, ISignedInAppCoordinator {
    private var window: UIWindow?
    
    init (window: UIWindow?) {
        self.window = window
    }
    
    func startAuthFlow() {
        let navigationController = UINavigationController()
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                             appCoordinator: self)
        authCoordinator.goToSignIn()
        self.window?.rootViewController = navigationController
    }
    
    func signInSuccess() {
        let signedInTabBarController = SignedInTabBarController()
        signedInTabBarController.signOutHandler = { [weak self] in
            try? Auth.auth().signOut()
            self?.startAuthFlow()
        }
        self.window?.rootViewController = signedInTabBarController
    }
}
