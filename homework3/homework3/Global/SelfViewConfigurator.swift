//
//  DefaultMainViewPresentation.swift
//  homework3
//
//  Created by 1okmon on 28.04.2023.
//

import Foundation
import UIKit

fileprivate enum Metrics {
    static let selfViewBackgroundColor = UIColor.white
}

protocol SelfViewConfigurator where Self: UIViewController {
    func configureBackgroundColor()
}

extension SelfViewConfigurator {
    func configureBackgroundColor(){
        self.view.backgroundColor = Metrics.selfViewBackgroundColor
    }
}
