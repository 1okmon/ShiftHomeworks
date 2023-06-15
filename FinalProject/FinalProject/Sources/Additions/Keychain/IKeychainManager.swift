//
//  IKeychainManager.swift
//  FinalProject
//
//  Created by 1okmon on 14.06.2023.
//

protocol IKeychainManager: ICleanKeychainManager {
    func update(email: String, password: String)
    func loadSingInDetails() -> UserSignInDetails?
}

protocol ICleanKeychainManager {
    func deleteSingInDetails()
}
