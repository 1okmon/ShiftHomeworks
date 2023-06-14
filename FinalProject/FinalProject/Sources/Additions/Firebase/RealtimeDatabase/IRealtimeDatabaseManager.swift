//
//  IRealtimeDatabaseManager.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import Foundation

protocol INewUserRealtimeDatabaseManager {
    func createNewUser(with id: String, email: String, completion: @escaping (IAlertRepresentable) -> Void)
}

protocol IUserDataRealtimeDatabaseManager {
    func updateUserData(to userData: UserData)
    func updateUserImageUrl(_ imageUrl: String)
    func loadUserData(completion: ((UserDataResponse) -> Void)?)
}
