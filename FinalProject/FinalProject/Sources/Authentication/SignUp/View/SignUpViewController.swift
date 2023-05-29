//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import Foundation
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
        configure()
    }
    
    override func presentAlert(of type: AuthResult) {
        if case .emailVerificationSent = type {
            let authDesignSystem = AuthDesignSystem()
            let alert = authDesignSystem.alert(
                title: type.title,
                message: type.message,
                buttonTitles: [ type.buttonTitle ],
                buttonActions: [ { [weak self] _ in
                    self?.signUpViewModel.goBack()
                } ])
            self.present(alert, animated: true, completion: nil)
        } else {
            super.presentAlert(of: type)
        }
    }
}

private extension SignUpViewController {
    func configure() {
        signUpView.submitSignUpTapHandler = {[weak self] email, password in
            self?.signUpViewModel.submitSignUp(with: email, password)
        }
    }
}
