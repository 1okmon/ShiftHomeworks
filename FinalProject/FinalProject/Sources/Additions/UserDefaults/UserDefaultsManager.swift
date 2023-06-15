//
//  UserDefaultsManager.swift
//  FinalProject
//
//  Created by 1okmon on 15.06.2023.
//

import Foundation

private enum Metrics {
    static let firstLaunchKey = "firstLaunch"
}

final class UserDefaultsManager: IFirstLaunchUserDefaultsManager {
    func isFirstLaunch() -> Bool {
        !UserDefaults.standard.bool(forKey: Metrics.firstLaunchKey)
    }
    
    func hasInstalled() {
        UserDefaults.standard.setValue(true, forKey: Metrics.firstLaunchKey)
    }
}
