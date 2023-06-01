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
    case favourites
    
    var item: UITabBarItem {
        switch self {
        case .profileInfo:
            return UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: self.rawValue)
        case .richAndMortyWiki:
            return UITabBarItem(title: "Рик и Морти Wiki", image: UIImage(systemName: "brain.head.profile"), tag: self.rawValue)
        case .favourites:
            return UITabBarItem(title: "Избранное", image: UIImage(systemName: "star"), tag: self.rawValue)
        }
    }
}

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor.withAlphaComponent(0.8)
    static let tintColor = Theme.tintColor
}

final class SignedInTabBarController: UITabBarController {
    private var profileViewController: ProfileViewController?
    private var rickAndMortyNavigationController: UINavigationController
    private var favouritesViewController: FavouritesViewController?
    
    init() {
        self.rickAndMortyNavigationController = UINavigationController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
        configureTabBarItems()
        configure(tabBar: tabBar)
        appendViewControllers()
    }
}

private extension SignedInTabBarController {
    func initViewControllers() {
        profileViewController = ProfileViewController()
        rickAndMortyNavigationController = UINavigationController()
        let rickAndMortyCoordinator = RickAndMortyCoordinator(navigationController: rickAndMortyNavigationController)
        favouritesViewController = FavouritesViewController()
    }
    
    func configureTabBarItems() {
        profileViewController?.tabBarItem = TabBarItemType.profileInfo.item
        rickAndMortyNavigationController.tabBarItem = TabBarItemType.richAndMortyWiki.item
        favouritesViewController?.tabBarItem = TabBarItemType.favourites.item
    }
    
    func configure(tabBar: UITabBar) {
        tabBar.backgroundColor = Metrics.backgroundColor
        tabBar.tintColor = Metrics.tintColor
    }
    
    func appendViewControllers() {
        guard let profileViewController = profileViewController,
              let favouritesViewController = favouritesViewController else { return }
        self.viewControllers = [profileViewController, rickAndMortyNavigationController, favouritesViewController]
    }
}
