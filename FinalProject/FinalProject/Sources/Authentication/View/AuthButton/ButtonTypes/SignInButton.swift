//
//  SignInButton.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

final class SignInButton: AuthButtonDecorator {    
    override func didTapped() {
        super.didTapped()
        print("sigIn")
    }
}
