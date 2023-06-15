//
//  IFirstLaunchUserDefaultsManager.swift
//  FinalProject
//
//  Created by 1okmon on 15.06.2023.
//

protocol IFirstLaunchUserDefaultsManager {
    func isFirstLaunch() -> Bool
    func hasInstalled()
}
