//
//  ProfilePresenter.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import UIKit

final class ProfilePresenter: IProfilePresenter {
    private unowned var viewController: ProfileViewController
    private var realtimeDatabaseManager: IUserDataRealtimeDatabaseManager
    private var firebaseStorageManager: IFirebaseStorageManager
    private var coordinator: IProfileCoordinator?
    private var keychainManager: ICleanKeychainManager
    
    init(viewController: ProfileViewController, coordinator: IProfileCoordinator) {
        self.viewController = viewController
        self.keychainManager = KeychainManager()
        self.firebaseStorageManager = FirebaseStorageManger()
        self.realtimeDatabaseManager = RealtimeDatabaseManager.shared
        self.coordinator = coordinator
    }
    
    func save(userData: UserData) {
        self.realtimeDatabaseManager.updateUserData(to: userData)
        guard let image = userData.image else { return }
        self.firebaseStorageManager.uploadImage(image) { [weak self] url, error in
            if let error = error {
                let alertRepresentableError = NetworkResponseCodeParser().parse(error: error)
                self?.viewController.showInfoAlert(of: alertRepresentableError)
            }
            guard let url = url else { return }
            self?.realtimeDatabaseManager.updateUserImageUrl(url.absoluteString)
        }
    }
    
    func fetchRemoteData() {
        self.realtimeDatabaseManager.loadUserData { [weak self] userDataResponse in
            guard let imageUrl = userDataResponse.imageUrl else { return }
            self?.firebaseStorageManager.loadImage(from: imageUrl, completion: { [weak self] data, error in
                if let error = error {
                    let alertRepresentableError = NetworkResponseCodeParser().parse(error: error)
                    self?.viewController.showInfoAlert(of: alertRepresentableError)
                }
                guard let data = data else { return }
                self?.viewController.update(with: UIImage(data: data))
            })
            self?.viewController.update(with: UserData(userDataResponse: userDataResponse))
        }
    }
    
    func signOut() {
        self.keychainManager.deleteSingInDetails()
        self.coordinator?.signOut()
    }
}
