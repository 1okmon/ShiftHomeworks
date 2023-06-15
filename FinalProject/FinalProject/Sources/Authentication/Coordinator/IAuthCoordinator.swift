//
//  IAuthCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

protocol IAuthCoordinator {
    func goToSignUp()
    func goToResetPassword()
    func signInConfirmed()
    func goBackToSignIn()
}
