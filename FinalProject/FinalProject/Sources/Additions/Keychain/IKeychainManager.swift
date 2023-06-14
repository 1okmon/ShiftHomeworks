//
//  IKeychainManager.swift
//  FinalProject
//
//  Created by 1okmon on 14.06.2023.
//

import Foundation
protocol IKeychainManager: ISignOutKeychainManager {
    func update(email: String, password: String)
    func loadSingInDetails() -> UserSignInDetails?
}

protocol ISignOutKeychainManager {
    func deleteSingInDetails()
}
