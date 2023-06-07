//
//  AppCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class AppCoordinator {
    private var window: UIWindow?
    private let coreDataManager: CoreDataManager
    
    init (window: UIWindow?) {
        self.window = window
        self.coreDataManager = CoreDataManager.shared
    }
    
    func startAuthFlow() {
        coreDataManager.clean()
        let navigationController = UINavigationController()
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                             appCoordinator: self)
        authCoordinator.start()
        self.window?.rootViewController = navigationController
    }
    
    func startSignedInFlow() {
        coreDataManager.loadUserData()
        self.window?.rootViewController = SignedInTabBarController()
    }
}
