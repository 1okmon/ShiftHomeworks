//
//  SignedInTabBarController.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

enum TabBarItemType: Int {
    case profileInfo
    case richAndMortyWiki
    case favorites
    
    var item: UITabBarItem {
        switch self {
        case .profileInfo:
            return UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: self.rawValue)
        case .richAndMortyWiki:
            return UITabBarItem(title: "Рик и Морти Wiki", image: UIImage(systemName: "brain.head.profile"), tag: self.rawValue)
        case .favorites:
            return UITabBarItem(title: "Избранное", image: UIImage(systemName: "star"), tag: self.rawValue)
        }
    }
}

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor.withAlphaComponent(0.8)
    static let tintColor = Theme.tintColor
}

final class SignedInTabBarController: UITabBarController {
    var signOutHandler: (() -> Void)?
    private var profileNavigationController: UINavigationController
    private var rickAndMortyNavigationController: UINavigationController
    private var favoritesNavigationController: UINavigationController
    
    init() {
        self.profileNavigationController = UINavigationController()
        self.rickAndMortyNavigationController = UINavigationController()
        self.favoritesNavigationController = UINavigationController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewControllers()
        self.configureTabBarItems()
        self.configure(tabBar: tabBar)
        self.appendViewControllers()
    }
}

private extension SignedInTabBarController {
    func initViewControllers() {
        let profileCoordinator = ProfileCoordinator(navigationController: self.profileNavigationController)
        profileCoordinator.signOutHandler = { [weak self] in
            self?.signOutHandler?()
        }
        _ = RickAndMortyCoordinator(navigationController: self.rickAndMortyNavigationController)
        _ = FavoritesCoordinator(navigationController: self.favoritesNavigationController)
    }
    
    func configureTabBarItems() {
        self.profileNavigationController.tabBarItem = TabBarItemType.profileInfo.item
        self.rickAndMortyNavigationController.tabBarItem = TabBarItemType.richAndMortyWiki.item
        self.favoritesNavigationController.tabBarItem = TabBarItemType.favorites.item
    }
    
    func configure(tabBar: UITabBar) {
        tabBar.backgroundColor = Metrics.backgroundColor
        tabBar.tintColor = Metrics.tintColor
    }
    
    func appendViewControllers() {
        self.viewControllers = [self.profileNavigationController,
                                self.rickAndMortyNavigationController,
                                self.favoritesNavigationController]
    }
}
