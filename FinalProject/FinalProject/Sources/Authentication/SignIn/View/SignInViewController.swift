//
//  SignInViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit
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
    }
    
    override func presentAlert(of type: AuthResult) {
        let authDesignSystem = AuthDesignSystem()
        if case let .emailNotVerified(user) = type {
            let alert = authDesignSystem.alert(
                title: type.title,
                message: type.message,
                buttonTitles: [ "Да", "Нет" ],
                buttonActions: [ { [weak self] _ in
                    self?.signInViewModel.sendEmailVerificationLink(to: user)
                } ])
            self.present(alert, animated: true, completion: nil)
        }
        if case .userNotFound = type {
            let alert = authDesignSystem.alert(
                title: type.title,
                message: type.message,
                buttonTitles: ["Да", "Нет"],
                buttonActions: [ { [weak self] _ in
                    self?.signInViewModel.signUp()
                } ])
            self.present(alert, animated: true, completion: nil)
        }
        if type == .wrongPassword || type == .tooManyRequests {
            self.signInView.showResetPasswordButton()
        }
        guard case .successSignIn = type else {
            super.presentAlert(of: type)
            return
        }
    }
}

private extension SignInViewController {
    func configure() {
        signInView.signInTapHandler = { [weak self] email, password in
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
