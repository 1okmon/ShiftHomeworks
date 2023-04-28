//
//  TabBarItemEnum.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation
import UIKit

enum TabBarItemEnum: Int {
    case profileInfo
    case hardSkills
    case hobbies
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .profileInfo:
            return UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: self.rawValue)
        case .hardSkills:
            return UITabBarItem(title: "Навыки", image: UIImage(systemName: "brain.head.profile"), tag: self.rawValue)
        case .hobbies:
            return UITabBarItem(title: "Хобби", image: UIImage(systemName: "figure.fishing"), tag: self.rawValue)
        }
    }
}
