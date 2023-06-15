//
//  SignInViewController.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 10.05.2023.
//

import UIKit

class AuthViewController: KeyboardSupportedViewController, IObserver {
    var id: UUID
    private var authView: AuthView
    
    init(authView: AuthView) {
        self.id = UUID()
        self.authView = authView
        super.init(keyboardSupportedView: authView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<T>(with value: T) {
        guard let result = value as? AuthResult else { return }
        self.authView.closeActivityIndicator()
        self.showInfoAlert(of: result)
    }
}
