//
//  AuthViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

final class AuthViewModel {
    var coordinator: IAuthCoordinator
    init(coordinator: IAuthCoordinator) {
        self.coordinator = coordinator
    }
}

extension AuthViewModel: IAuthViewModel {
    func signIn() {
        print("tapped sign in")
    }
    
    func signUp() {
        coordinator.goToSignUp()
    }
    
    func resetPassword() {
        coordinator.goToResetPassword()
    }
    
    func submitSignUp() {
        print("tapped submit sign up")
    }
    
    func submitResetPassword() {
        print("tapped submit reset password")
    }
}
