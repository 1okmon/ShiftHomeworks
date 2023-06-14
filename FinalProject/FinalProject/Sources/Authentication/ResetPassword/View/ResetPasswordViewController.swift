//
//  ResetPasswordViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

private enum Metrics {
    enum AlertButtonTitle {
        static let confirmAction = "Да"
        static let declineAction = "Нет"
    }
}

final class ResetPasswordViewController: AuthViewController {
    private var viewModel: IResetPasswordViewModel
    private var resetPasswordView: ResetPasswordView
    
    init(resetPasswordView: ResetPasswordView, resetPasswordViewModel: IResetPasswordViewModel) {
        self.resetPasswordView = resetPasswordView
        self.viewModel = resetPasswordViewModel
        super.init(authView: resetPasswordView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func update<T>(with value: T) {
        if let error = value as? AuthResult, error == .userNotFound {
            let alert = AlertBuilder().setFieldsToShowAlert(of: error)
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.confirmAction,
                                         style: .default,
                                         handler: { [weak self] _ in
                    self?.viewModel.signUp()
                }))
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.declineAction,
                                         style: .default))
                .build()
            self.present(alert, animated: true)
            self.resetPasswordView.closeActivityIndicator()
            return
        }
        if let error = value as? IAlertRepresentable {
            self.presentAlert(of: error)
        }
        super.update(with: value)
    }
    
    func presentAlert(of errorCode: IAlertRepresentable) {
        guard case AuthResult.resetPasswordLinkSent = errorCode else { return }
        let alert = AlertBuilder()
            .setFieldsToShowAlert(of: errorCode)
            .addAction(UIAlertAction(title: errorCode.buttonTitle,
                                     style: .default,
                                     handler: { [weak self] _ in
                self?.viewModel.goBackToSignIn()
            }))
            .build()
        self.present(alert, animated: true, completion: nil)
    }
}

private extension ResetPasswordViewController {
    func configure() {
        self.resetPasswordView.submitResetPasswordTapHandler = { [weak self] email in
            guard let email = email, !email.isEmpty else {
                self?.showInfoAlert(of: AuthResult.fieldsNotFilled)
                return
            }
            self?.resetPasswordView.showActivityIndicator()
            self?.viewModel.submitResetPassword(with: email)
        }
    }
}
