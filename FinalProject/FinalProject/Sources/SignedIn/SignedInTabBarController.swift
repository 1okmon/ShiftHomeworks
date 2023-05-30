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
     private var locationSkillsViewController: LocationViewController?
     private var favouritesViewController: FavouritesViewController?

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
         locationSkillsViewController = LocationViewController()
         favouritesViewController = FavouritesViewController()
     }

     func configureTabBarItems() {
         profileViewController?.tabBarItem = TabBarItemType.profileInfo.item
         locationSkillsViewController?.tabBarItem = TabBarItemType.richAndMortyWiki.item
         favouritesViewController?.tabBarItem = TabBarItemType.favourites.item
     }

     func configure(tabBar: UITabBar) {
         tabBar.backgroundColor = Metrics.backgroundColor
         tabBar.tintColor = Metrics.tintColor
     }

     func appendViewControllers() {
         guard let profileViewController = profileViewController,
               let locationSkillsViewController = locationSkillsViewController,
               let favouritesViewController = favouritesViewController else { return }
         self.viewControllers = [profileViewController, locationSkillsViewController, favouritesViewController]
     }
 }
