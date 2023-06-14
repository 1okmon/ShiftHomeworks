//
//  IProfilePresenter.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import Foundation

protocol IProfilePresenter {
    func fetchRemoteData()
    func save(userData: UserData)
    func signOut()
}
