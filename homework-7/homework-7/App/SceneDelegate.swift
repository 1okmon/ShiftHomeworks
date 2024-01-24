//
//  SceneDelegate.swift
//  homework-7
//
//  Created by 1okmon on 29.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = ImagesLoadingViewController()
        let viewModel = ImagesLoadingViewModel()
        viewController.setViewModel(viewModel: viewModel)
        viewModel.subscribe(observer: viewController)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}
