//
//  SignInViewController.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 10.05.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    private var authViewModel: IAuthViewModel
    private var authView: AuthView
    
    init(authView: AuthView, authViewModel: IAuthViewModel) {
        self.authView = authView
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

private extension AuthViewController {
    func configure() {
        self.view.backgroundColor = .white
        configure(authView: authView)
    }
    
    func configure(authView: AuthView) {
        self.view.addSubview(authView)
        configureConstraints(at: authView)
    }
    
    func configureConstraints(at authView: UIView) {
        authView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    
}
