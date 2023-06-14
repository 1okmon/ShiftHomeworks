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
    
    override func presentAlert(of type: AuthResult) {
        if case .resetPasswordLinkSent = type {
            let authDesignSystem = AuthDesignSystem()
            let alert = authDesignSystem.alert(
                title: type.title,
                message: type.message,
                buttonTitles: [ type.buttonTitle ],
                buttonActions: [ { [weak self] _ in
                    self?.resetPasswordViewModel.goBack()
                } ])
            self.present(alert, animated: true, completion: nil)
        } else {
            super.presentAlert(of: type)
        }
    }
}

private extension ResetPasswordViewController {
    func configure() {
        resetPasswordView.submitResetPasswordTapHandler = {[weak self] email in
            self?.resetPasswordViewModel.submitResetPassword(with: email)
        }
    }
}
