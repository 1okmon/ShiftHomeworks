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
    private var actions: [UIAlertAction]
    
    init() {
        self.alertTitle = String()
        self.alertMessage = String()
        self.alertStyle = .alert
        self.actions = []
    }
    
    func addAction(_ action: UIAlertAction) -> AlertBuilder {
        self.actions.append(action)
        return self
    }
    
    func build() -> UIAlertController {
        let alertController = UIAlertController(title: self.alertTitle,
                                                 message: self.alertMessage,
                                                 preferredStyle: self.alertStyle)
        self.actions.forEach { action in
            alertController.addAction(action)
        }
        return alertController
    }
    
    func setFieldsToShowAlert(of errorCode: IAlertRepresentable) -> AlertBuilder {
        self.alertTitle = errorCode.title
        self.alertMessage = errorCode.message
        return self
    }
    
    func setAlertStyle(_ style: UIAlertController.Style) -> AlertBuilder {
        self.alertStyle = style
        return self
    }
}
