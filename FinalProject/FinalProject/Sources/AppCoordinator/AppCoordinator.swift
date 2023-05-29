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
//        let navigationController = UINavigationController.init()
//        let appCoordinator = AuthCoordinator(navigationController: navigationController)
//        appCoordinator?.start()
    }
    
    func startAuthFlow() {
        let appCoordinator = AuthCoordinator(navigationController: navigationController, appCoordinator: self)
        appCoordinator.start()
    }
    
    func startProfileFlow() {
        let profileViewController = ProfileViewController()
        self.navigationController.viewControllers = [profileViewController]
    }
    
    func signInConfirmed() {
        startProfileFlow()
    }
}
