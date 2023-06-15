//
//  ISignUpViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

protocol ISignUpViewModel {
    func submitSignUp(with email: String, _ password: String)
    func goBackToSignIn()
}
