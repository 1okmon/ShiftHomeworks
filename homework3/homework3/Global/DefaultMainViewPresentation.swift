//
//  DefaultMainViewPresentation.swift
//  homework3
//
//  Created by 1okmon on 28.04.2023.
//

import Foundation
import UIKit

fileprivate enum MainView {
    static let backgroundColor = UIColor.white
}

protocol DefaultMainViewPresentation where Self: UIViewController {
    func configureMainViewPresentation()
}

extension DefaultMainViewPresentation {
    func configureMainViewPresentation(){
        self.view.backgroundColor = MainView.backgroundColor
    }
}
