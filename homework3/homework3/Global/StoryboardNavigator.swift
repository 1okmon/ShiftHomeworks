//
//  StoryboardNavigator.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit

fileprivate enum StoryboardsNames {
    static let main = "Main"
}

struct StoryboardNavigator {
    static func viewController(from storyboardName: String?, withIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(
            name: storyboardName ?? StoryboardsNames.main,
            bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        return targetVC
    }
}
