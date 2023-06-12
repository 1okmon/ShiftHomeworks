//
//  IFirebase.swift
//  FinalProject
//
//  Created by 1okmon on 25.05.2023.
//

import Firebase
protocol IFirebaseNetworkManager {
    func signIn(with email: String, _ password: String, completion: @escaping (IAlertRepresentable) -> Void)
    func submitSignUp(with email: String, _ password: String, completion: @escaping (IAlertRepresentable) -> Void)
    func submitResetPassword(with email: String, completion: @escaping (IAlertRepresentable) -> Void)
    func sendEmailConfirmation(to user: User, completion: @escaping (IAlertRepresentable) -> Void)
}
