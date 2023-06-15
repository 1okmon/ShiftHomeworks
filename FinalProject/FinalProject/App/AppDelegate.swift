//
//  AppDelegate.swift
//  FinalProject
//
//  Created by 1okmon on 19.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CoreData

private enum Metrics {
    static let rickAndMortyDBName = "RickAndMortyData"
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        let firstLaunchManager: IFirstLaunchUserDefaultsManager = UserDefaultsManager()
        let keychainManager: ICleanKeychainManager = KeychainManager()
        if firstLaunchManager.isFirstLaunch() {
            keychainManager.deleteSingInDetails()
            firstLaunchManager.hasInstalled()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Metrics.rickAndMortyDBName)
        container.loadPersistentStores { _, error in
            guard error == nil else { return }
        }
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        guard context.hasChanges else { return }
        try? context.save()
    }
}
