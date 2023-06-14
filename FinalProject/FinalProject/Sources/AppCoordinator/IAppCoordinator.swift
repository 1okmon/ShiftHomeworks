//
//  IAppCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 14.06.2023.
//

import Foundation
protocol ISignInAppCoordinator {
    func startAuthFlow()
}

protocol ISignedInAppCoordinator {
    func signInSuccess()
}
