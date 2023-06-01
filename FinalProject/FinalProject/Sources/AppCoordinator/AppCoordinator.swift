//
//  AppCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class AppCoordinator {
    func authFlow() -> UINavigationController {
        let navigationController = UINavigationController()
        let appCoordinator = AuthCoordinator(navigationController: navigationController,
                                             appCoordinator: self)
        appCoordinator.start()
        return navigationController
    }
    
    func signedInFlow() -> UITabBarController {
        return SignedInTabBarController()
    }
    
    func signInConfirmed() {
        //firstAtSignedInFlow()
    }
}
