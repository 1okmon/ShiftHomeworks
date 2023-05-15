//
//  NavigationController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [CarsViewController()]
    }
}
