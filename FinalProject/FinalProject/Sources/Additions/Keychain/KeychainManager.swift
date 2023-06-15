//
//  KeychainManager.swift
//  FinalProject
//
//  Created by 1okmon on 14.06.2023.
//

import Locksmith

private enum Metrics {
    static let emailKey = "email"
    static let passwordKey = "password"
    static let keychainKey = "UserSignInDetails"
}

final class KeychainManager: IKeychainManager {
    func update(email: String, password: String) {
        try? Locksmith.updateData(data: [Metrics.emailKey: email,
                                         Metrics.passwordKey: password],
                                  forUserAccount: Metrics.keychainKey)
        
    }
    
    func loadSingInDetails() -> UserSignInDetails? {
        let userSignInDetails = Locksmith.loadDataForUserAccount(userAccount: Metrics.keychainKey)
        guard let userSignInDetails = userSignInDetails as? [String: String],
              let email = userSignInDetails[Metrics.emailKey],
              let password = userSignInDetails[Metrics.passwordKey] else {
            return nil
        }
        return UserSignInDetails(email: email, password: password)
    }
    
    func deleteSingInDetails() {
        try? Locksmith.deleteDataForUserAccount(userAccount: Metrics.keychainKey)
    }
}
