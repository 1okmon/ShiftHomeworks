//
//  AuthButtonDecorator.swift
//  FinalProject
//
//  Created by 1okmon on 18.05.2023.
//

import UIKit

class AuthButtonDecorator: UIButton, IAuthButton {
    private let decorator: IAuthButton
    private var actionByTap: (()->Void)?
    
    required init(decorator: IAuthButton, action: (()->Void)?) {
        self.decorator = decorator
        self.actionByTap = action
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(didTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapped() {
        guard let action = actionByTap else { return }
        action()
    }
}
