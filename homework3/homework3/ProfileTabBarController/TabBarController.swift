//
//  TabBarController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit

fileprivate enum TabBarMetrics {
    static let backgroundColor = UIColor.white.withAlphaComponent(0.8)
    static let tintColor = UIColor.black
}

final class TabBarController: UITabBarController {
    private var mainInfoViewController: MainInfoViewController?
    private var developerSkillsViewController: DeveloperSkillsViewController?
    private var hobbiesViewController: HobbiesViewController?
    
    private func initViewControllers() {
        mainInfoViewController = StoryboardNavigator.viewController(from: nil, withIdentifier: MainInfoViewController.className) as? MainInfoViewController
        developerSkillsViewController = DeveloperSkillsViewController()
        hobbiesViewController = HobbiesViewController()
    }
    
    private func configureTabBarItems() {
        mainInfoViewController?.tabBarItem = TabBarItemType.profileInfo.item
        developerSkillsViewController?.tabBarItem = TabBarItemType.hardSkills.item
        hobbiesViewController?.tabBarItem = TabBarItemType.hobbies.item
    }
    
    private func configure(tabBar: UITabBar) {
        tabBar.backgroundColor = TabBarMetrics.backgroundColor
        tabBar.tintColor = TabBarMetrics.tintColor
    }
    
    private func appendViewControllers() {
        guard let mainInfoViewController = mainInfoViewController,
              let developerSkillsViewController = developerSkillsViewController,
              let hobbiesViewController = hobbiesViewController else { return }
        self.viewControllers = [mainInfoViewController, developerSkillsViewController, hobbiesViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
        configureTabBarItems()
        configure(tabBar: tabBar)
        appendViewControllers()
    }
}
