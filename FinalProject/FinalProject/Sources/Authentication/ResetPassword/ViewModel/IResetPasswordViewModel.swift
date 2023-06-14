//
//  IResetPasswordViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import Foundation
protocol IResetPasswordViewModel {
    func submitResetPassword(with email: String)
    func goBackToSignIn()
    func signUp()
}
