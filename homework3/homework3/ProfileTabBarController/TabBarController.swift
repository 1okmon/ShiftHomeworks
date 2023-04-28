//
//  TabBarController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit

fileprivate enum TabBarView {
    static let backgroundColor = UIColor.white.withAlphaComponent(0.8)
    static let tintColor = UIColor.black
}

final class TabBarController: UITabBarController {
    private var mainInfoViewController: MainInfoViewController?
    private var developerSkillsViewController: DeveloperSkillsViewController?
    private var hobbiesViewController: HobbiesViewController?
    
    private func initViewControllers() {
        mainInfoViewController = StoryboardNavigator.getVCFromMain(withIdentifier: MainInfoViewController.className) as? MainInfoViewController
        developerSkillsViewController = DeveloperSkillsViewController()
        hobbiesViewController = HobbiesViewController()
    }
    
    private func configureTabBarItems() {
        mainInfoViewController?.tabBarItem = TabBarItemEnum.profileInfo.tabBarItem
        developerSkillsViewController?.tabBarItem = TabBarItemEnum.hardSkills.tabBarItem
        hobbiesViewController?.tabBarItem = TabBarItemEnum.hobbies.tabBarItem
    }
    
    private func configureTabBarView() {
        tabBar.backgroundColor = TabBarView.backgroundColor
        tabBar.tintColor = TabBarView.tintColor
    }
    
    private func configureTabBarViewControllers() {
        guard let mainInfoViewController = mainInfoViewController,
              let developerSkillsViewController = developerSkillsViewController,
              let hobbiesViewController = hobbiesViewController else { return }
        self.viewControllers = [mainInfoViewController, developerSkillsViewController, hobbiesViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
        configureTabBarItems()
        configureTabBarView()
        configureTabBarViewControllers()
    }
}
