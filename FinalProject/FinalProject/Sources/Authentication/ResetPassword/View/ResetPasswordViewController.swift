//
//  ResetPasswordViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
final class ResetPasswordViewController: AuthViewController {
    private var resetPasswordViewModel: IResetPasswordViewModel
    private var resetPasswordView: ResetPasswordView
    
    init(resetPasswordView: ResetPasswordView, resetPasswordViewModel: IResetPasswordViewModel) {
        self.resetPasswordView = resetPasswordView
        self.resetPasswordViewModel = resetPasswordViewModel
        super.init(authView: resetPasswordView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func update<T>(with value: T) {
        if let error = value as? IAlertRepresentable {
            presentAlert(of: error)
        }
        super.update(with: value)
    }
    
    func presentAlert(of errorCode: IAlertRepresentable) {
        guard case AuthResult.resetPasswordLinkSent = errorCode else { return }
        let alert = AlertBuilder()
            .setFieldsToShowAlert(of: errorCode)
//            .setTitle(errorCode.title)
//            .setMessage(errorCode.message)
            .addAction(UIAlertAction(title: errorCode.buttonTitle, style: .default, handler: { [weak self] _ in
                self?.resetPasswordViewModel.goBack()
            })).build()
        self.present(alert, animated: true, completion: nil)
    }
}

private extension ResetPasswordViewController {
    func configure() {
        resetPasswordView.submitResetPasswordTapHandler = {[weak self] email in
            self?.resetPasswordViewModel.submitResetPassword(with: email)
        }
    }
}
