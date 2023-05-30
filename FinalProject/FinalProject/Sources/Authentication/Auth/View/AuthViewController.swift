//
//  SignInViewController.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 10.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

class AuthViewController: UIViewController, IObserver {
    var id: UUID
    private var keyboardWillShowHandler: ((CGFloat) -> Void)?
    private var keyboardWillHideHandler: (() -> Void)?
    private var authView: AuthView
    
    init(authView: AuthView) {
        self.id = UUID()
        self.authView = authView
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
    
    func update<T>(with value: T) {
        guard let result = value as? AuthResult else { return }
        authView.closeActivityIndicatory()
        presentAlert(of: result)
    }
    
    func presentAlert(of type: AuthResult) {
        presentAlert(with: type.title, type.message, "ok")
    }
}

private extension AuthViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
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
        authView.alertHandler = { [weak self] alertTitle, alertMessage, buttonTitle in
            self?.presentAlert(with: alertTitle, alertMessage, buttonTitle)
        }
        keyboardWillShowHandler = { [weak self] keyboardHeight in
            self?.authView.keyboardWillShow(keyboardHeight: keyboardHeight)
        }
        keyboardWillHideHandler = { [weak self] in
            self?.authView.keyboardWillHide()
        }
    }
    
    func presentAlert(with alertTitle: String, _ alertMessage: String, _ buttonTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
