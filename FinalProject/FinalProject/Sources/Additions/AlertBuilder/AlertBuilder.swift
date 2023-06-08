//
//  AlertBuilder.swift
//  FinalProject
//
//  Created by 1okmon on 08.06.2023.
//

import UIKit

final class AlertBuilder {
    private var alertTitle: String
    private var alertMessage: String
    private var alertStyle: UIAlertController.Style
    private let alertController: UIAlertController
    private var actions: [UIAlertAction]
    
    init() {
        self.alertTitle = String()
        self.alertMessage = String()
        self.alertController = UIAlertController()
        self.alertStyle = .alert
        self.actions = []
    }
    
    func addAction(_ action: UIAlertAction) -> AlertBuilder {
        self.actions.append(action)
        return self
    }
    
    func build() -> UIAlertController {
        self.actions.forEach { action in
            self.alertController.addAction(action)
        }
        return self.alertController
    }
    
    func setAlertStyle(_ style: UIAlertController.Style) -> AlertBuilder {
        self.alertStyle = style
        return self
    }
}
