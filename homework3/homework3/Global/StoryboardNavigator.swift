//
//  StoryboardNavigator.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit

struct StoryboardNavigator {
    static func getVCFromMain(withIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        return targetVC
    }
}
