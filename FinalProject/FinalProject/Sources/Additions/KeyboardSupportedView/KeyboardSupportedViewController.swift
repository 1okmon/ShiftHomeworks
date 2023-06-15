//
//  KeyboardSupportedViewController.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

class KeyboardSupportedViewController: UIViewController {
    private var keyboardSupportedView: KeyboardSupportedView
    private var keyboardWillShowHandler: ((CGFloat) -> Void)?
    private var keyboardWillHideHandler: (() -> Void)?
    
    init(keyboardSupportedView: KeyboardSupportedView) {
        self.keyboardSupportedView = keyboardSupportedView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

private extension KeyboardSupportedViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        self.configureView()
    }
    
    func configureView() {
        self.view.addSubview(self.keyboardSupportedView)
        self.configureViewHandlers()
        self.addAuthGestureRecognizer()
        self.configureViewConstraints()
    }
    
    func configureViewConstraints() {
        self.keyboardSupportedView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configureViewHandlers() {
        self.keyboardWillShowHandler = { [weak self] keyboardHeight in
            self?.keyboardSupportedView.keyboardWillShow(keyboardHeight: keyboardHeight)
        }
        self.keyboardWillHideHandler = { [weak self] in
            self?.keyboardSupportedView.keyboardWillHide()
        }
    }
    func addAuthGestureRecognizer() {
        self.keyboardSupportedView.addGestureRecognizer(UITapGestureRecognizer(target: self.view,
                                                             action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        guard let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        guard let keyboardWillShowHandler = self.keyboardWillShowHandler else { return }
        keyboardWillShowHandler(keyboardHeight)
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        guard let keyboardWillHideHandler = self.keyboardWillHideHandler else { return }
        keyboardWillHideHandler()
    }
}
