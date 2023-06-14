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
    private let coreDataManager: CoreDataManager
    
    init (window: UIWindow?) {
        self.window = window
        self.coreDataManager = CoreDataManager.shared
    }
    
    func startAuthFlow() {
        self.coreDataManager.clean()
        let navigationController = UINavigationController()
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                             appCoordinator: self)
        authCoordinator.start()
        self.window?.rootViewController = navigationController
    }
    
    func signInSuccess() {
        self.coreDataManager.loadUserData()
        let signedInTabBarController = SignedInTabBarController()
        signedInTabBarController.signOutHandler = { [weak self] in
            try? Auth.auth().signOut()
            self?.startAuthFlow()
        }
        self.window?.rootViewController = signedInTabBarController
    }
}
