//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class SignUpViewController: AuthViewController {
    private var signUpViewModel: ISignUpViewModel
    private var signUpView: SignUpView
    
    init(signUpView: SignUpView, signUpViewModel: ISignUpViewModel) {
        self.signUpView = signUpView
        self.signUpViewModel = signUpViewModel
        super.init(authView: signUpView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    override func update<T>(with value: T) {
        if let error = value as? IAlertRepresentable {
            self.presentAlert(of: error)
        }
        super.update(with: value)
    }
    
    func presentAlert(of errorCode: IAlertRepresentable) {
        guard case AuthResult.emailVerificationSent = errorCode else { return }
        let alert = AlertBuilder()
            .setFieldsToShowAlert(of: errorCode)
            .addAction(UIAlertAction(title: errorCode.buttonTitle, style: .default, handler: { [weak self] _ in
                self?.signUpViewModel.goBackToSignIn()
            }))
            .build()
        self.present(alert, animated: true, completion: nil)
    }
}

private extension SignUpViewController {
    func configure() {
        self.signUpView.submitSignUpTapHandler = { [weak self] email, password, repeatPassword in
            guard !email.isEmpty,
                  !password.isEmpty,
                  !repeatPassword.isEmpty else {
                self?.showInfoAlert(of: AuthResult.fieldsNotFilled)
                return
            }
            guard password == repeatPassword else {
                self?.showInfoAlert(of: AuthResult.passwordsNotEqual)
                return
            }
            self?.signUpView.showActivityIndicator()
            self?.signUpViewModel.submitSignUp(with: email, password)
        }
    }
}
