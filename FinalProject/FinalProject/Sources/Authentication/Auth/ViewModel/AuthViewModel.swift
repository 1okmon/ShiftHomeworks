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
    private var result: Observable<AuthResult>
    
    init(coordinator: IAuthCoordinator, firebaseNetworkManager: IFirebaseNetworkManager) {
        self.coordinator = coordinator
        self.firebaseNetworkManager = firebaseNetworkManager
        self.result = Observable<AuthResult>()
    }
    
    func subscribe(observer: IObserver) {
        self.result.subscribe(observer: observer)
    }
}

extension AuthViewModel: IAuthViewModel {
    func sendEmailVerificationLink(to user: User) {
        firebaseNetworkManager.sendEmailConfirmation(to: user, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func signIn(with email: String, _ password: String) {
        firebaseNetworkManager.signIn(with: email, password, completion: { [weak self] result in
            self?.result.value = result
            if case .successSignIn = result {
                self?.coordinator.signInConfirmed()
            }
        })
    }
    
    func signUp() {
        coordinator.goToSignUp()
    }
    
    func resetPassword() {
        coordinator.goToResetPassword()
    }
    
    func submitSignUp(with email: String, _ password: String) {
        firebaseNetworkManager.submitSignUp(with: email, password, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func submitResetPassword(with email: String) {
        firebaseNetworkManager.submitResetPassword(with: email, completion: { [weak self] result in
            self?.result.value = result
        })
    }
    
    func goBack() {
        self.coordinator.goBack()
    }
}
