//
//  ProfilePresenter.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import UIKit

class ProfilePresenter: IProfilePresenter {
    private unowned var viewController: ProfileViewController
    private var realtimeDatabaseManager: IUserDataRealtimeDatabaseManager
    private var coordinator: IProfileCoordinator?
    
    init(viewController: ProfileViewController, coordinator: IProfileCoordinator) {
        self.viewController = viewController
        self.realtimeDatabaseManager = RealtimeDatabaseManager.shared
        self.coordinator = coordinator
    }
    
    func save(userData: UserData) {
        self.realtimeDatabaseManager.updateUserData(to: userData)
    }
    
    func fetchRemoteData() {
        self.realtimeDatabaseManager.loadUserData { [weak self] userDataResponse in
            self?.viewController.update(with: UserData(userDataResponse: userDataResponse))
        }
    }
    
    func signOut() {
        self.coordinator?.signOut()
    }
}
