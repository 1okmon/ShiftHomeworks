//
//  ProfileCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import UIKit

class ProfileCoordinator: IProfileCoordinator {
    var signOutHandler: (() -> Void)?
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.start()
    }
    
    func signOut() {
        self.signOutHandler?()
    }
}

private extension ProfileCoordinator {
    func start() {
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(viewController: profileViewController, coordinator: self)
        profileViewController.setPresenter(profilePresenter)
        self.navigationController.pushViewController(profileViewController, animated: true)
    }
}
