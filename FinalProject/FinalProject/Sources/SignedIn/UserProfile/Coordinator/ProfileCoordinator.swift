//
//  ProfileCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import UIKit

class ProfileCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        start()
    }
    
    func start() {
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(viewController: profileViewController, coordinator: self)
        profileViewController.setPresenter(profilePresenter)
        self.navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func signOut() {
        
    }
}
