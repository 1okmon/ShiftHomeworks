//
//  SignInViewController.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 10.05.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    private var keyboardWillShowHandler: ((CGFloat) -> Void)?
    private var keyboardWillHideHandler: (() -> Void)?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

private extension AuthViewController {
    func configure() {
        self.view.backgroundColor = .white
        configureAuthView()
    }
    
    func configureAuthView() {
        self.view.addSubview(authView)
        configureAuthViewHandlers()
        addAuthViewGestureRecognizer()
        configureAuthViewConstraints()
    }
    
    func configureAuthViewConstraints() {
        authView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configureAuthViewHandlers() {
        keyboardWillShowHandler = { [weak self] keyboardHeight in
            self?.authView.keyboardWillShow(keyboardHeight: keyboardHeight)
        }
        keyboardWillHideHandler = { [weak self] in
            self?.authView.keyboardWillHide()
        }
    }
    
    func addAuthViewGestureRecognizer() {
        authView.addGestureRecognizer(UITapGestureRecognizer(target: self.view,
                                                             action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        guard let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        guard let keyboardWillShowHandler = keyboardWillShowHandler else { return }
        keyboardWillShowHandler(keyboardHeight)
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        guard let keyboardWillHideHandler = keyboardWillHideHandler else { return }
        keyboardWillHideHandler()
    }
}