//
//  AppCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class AppCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startAuthFlow() {
        let appCoordinator = AuthCoordinator(navigationController: navigationController, appCoordinator: self)
        appCoordinator.start()
    }
    
    func startSignedInFlow() {
        let tabBarViewController = SignedInTabBarController()
        //let profileViewController = ProfileViewController()
        self.navigationController.viewControllers = [tabBarViewController]
    }
    
    func signInConfirmed() {
        startSignedInFlow()
    }
}
