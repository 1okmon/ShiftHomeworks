//
//  UIViewController+showInfoAlert.swift
//  FinalProject
//
//  Created by 1okmon on 12.06.2023.
//

import UIKit

extension UIViewController {
    func showInfoAlert(of errorCode: IAlertRepresentable) {
        DispatchQueue.main.async {
            let alertController = AlertBuilder()
                .setFieldsToShowAlert(of: errorCode)
                .addAction(UIAlertAction(title: errorCode.buttonTitle, style: .default))
                .build()
            self.present(alertController, animated: true)
        }
    }
}
