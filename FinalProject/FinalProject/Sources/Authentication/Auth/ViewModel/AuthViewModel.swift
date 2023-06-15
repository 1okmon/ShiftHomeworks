//
//  AuthViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import Firebase

final class AuthViewModel {
    private var coordinator: IAuthCoordinator
    private var firebaseNetworkManager: IFirebaseNetworkManager
    private var result: Observable<IAlertRepresentable>
    private var userSignInDetails: Observable<UserSignInDetails>
    private var keychainManager: IKeychainManager
    private let coreDataManager: INewSignInCoreDataManager
    
    init(coordinator: IAuthCoordinator, firebaseNetworkManager: IFirebaseNetworkManager) {
        self.coordinator = coordinator
        self.keychainManager = KeychainManager()
        self.userSignInDetails = Observable<UserSignInDetails>()
        self.firebaseNetworkManager = firebaseNetworkManager
        self.result = Observable<IAlertRepresentable>()
        self.coreDataManager = CoreDataManager.shared
    }
    
    func subscribe(observer: IObserver) {
        self.userSignInDetails.subscribe(observer: observer)
        self.result.subscribe(observer: observer)
    }
}

extension AuthViewModel: IAuthViewModel {
    func sendEmailVerificationLink(to user: User) {
        self.firebaseNetworkManager.sendEmailConfirmation(to: user, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func trySignInByUserDetailsFromKeychain() {
        if let userSignInDetails = self.keychainManager.loadSingInDetails() {
            self.userSignInDetails.value = userSignInDetails
            self.firebaseNetworkManager.signIn(with: userSignInDetails.email, userSignInDetails.password, completion: { [weak self] result in
                if case AuthResult.successSignIn = result {
                    self?.coordinator.signInConfirmed()
                    self?.coreDataManager.loadUserData()
                } else {
                    self?.coreDataManager.clean()
                    self?.keychainManager.deleteSingInDetails()
                    self?.result.value = result
                }
            })
        }
    }
    
    func signIn(with email: String, _ password: String) {
        self.firebaseNetworkManager.signIn(with: email, password, completion: { [weak self] result in
            guard case AuthResult.successSignIn = result  else {
                self?.result.value = result
                return
            }
            self?.keychainManager.update(email: email, password: password)
            self?.coreDataManager.clean()
            self?.coreDataManager.loadUserData()
            self?.coordinator.signInConfirmed()
        })
    }
    
    func signUp() {
        self.coordinator.goToSignUp()
    }
    
    func resetPassword() {
        self.coordinator.goToResetPassword()
    }
    
    func submitSignUp(with email: String, _ password: String) {
        self.firebaseNetworkManager.submitSignUp(with: email, password, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func submitResetPassword(with email: String) {
        self.firebaseNetworkManager.submitResetPassword(with: email, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func goBackToSignIn() {
        self.coordinator.goBackToSignIn()
    }
}
