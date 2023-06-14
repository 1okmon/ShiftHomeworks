//
//  SignInViewController.swift
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

final class SignInViewController: AuthViewController {
    private var signInViewModel: ISignInViewModel
    private var signInView: SignInView
    
    init(signInView: SignInView, signInViewModel: ISignInViewModel) {
        self.signInView = signInView
        self.signInViewModel = signInViewModel
        super.init(authView: signInView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        start()
    }
    
    func start() {
        self.signInViewModel.trySignInByUserDetailsFromKeychain()
    }
    
    override func update<T>(with value: T) {
        if let error = value as? IAlertRepresentable {
            presentAlert(of: error)
        }
        if let userSignInDetails = value as? UserSignInDetails {
            self.signInView.update(with: userSignInDetails)
        }
        super.update(with: value)
    }
    
    func presentAlert(of result: IAlertRepresentable) {
        let alertBuilder = AlertBuilder().setFieldsToShowAlert(of: result)
        guard let authResult = result as? AuthResult else {
            return
        }
        if case let AuthResult.emailNotVerified(user) = authResult {
            let alert = alertBuilder
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.confirmAction,
                                         style: .default,
                                         handler: { [weak self] _ in
                    self?.signInViewModel.sendEmailVerificationLink(to: user)
                }))
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.declineAction, style: .default))
                .build()
            self.present(alert, animated: true, completion: nil)
        }
        if case AuthResult.userNotFound = authResult {
            let alert = alertBuilder
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.confirmAction,
                                         style: .default,
                                         handler: { [weak self] _ in
                    self?.signInViewModel.signUp()
                }))
                .addAction(UIAlertAction(title: Metrics.AlertButtonTitle.declineAction, style: .default))
                .build()
            self.present(alert, animated: true, completion: nil)
        }
        
        if authResult == AuthResult.wrongPassword || authResult == AuthResult.tooManyRequests {
            self.signInView.showResetPasswordButton()
        }
    }
}

private extension SignInViewController {
    func configure() {
        signInView.signInTapHandler = { [weak self] email, password in
            guard !email.isEmpty,
                  !password.isEmpty else {
                self?.showInfoAlert(of: AuthResult.fieldsNotFilled)
                return
            }
            self?.signInView.showActivityIndicator()
            self?.signInViewModel.signIn(with: email, password)
        }
        signInView.signUpTapHandler = { [weak self] in
            self?.signInViewModel.signUp()
        }
        signInView.resetPasswordTapHandler = {[weak self] in
            self?.signInViewModel.resetPassword()
        }
    }
}
