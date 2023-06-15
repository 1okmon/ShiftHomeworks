//
//  ISignInViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import Firebase

protocol ISignInViewModel {
    func signIn(with email: String, _ password: String)
    func signUp()
    func resetPassword()
    func sendEmailVerificationLink(to user: User)
    func trySignInByUserDetailsFromKeychain()
}
