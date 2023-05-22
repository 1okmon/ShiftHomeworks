//
//  Subviews.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

private enum Metrics {
    static let cornerRadius: CGFloat = 15
    static let textFieldBorderWidth: CGFloat = 2
    static let buttonBorderWidth: CGFloat = 3
    static let textFieldLeftViewWidth: CGFloat = 15
    static let borderColor = UIColor.black.cgColor
    static let backgroundColor = UIColor.white
    static let textAlignment: NSTextAlignment = .center
    static let standardFont = UIFont.systemFont(ofSize: 20)
    static let titleFont = UIFont.systemFont(ofSize: 30)
    static let fontColor = UIColor.black
    static let forgotPasswordFontColor = #colorLiteral(red: 0.2247311473, green: 0.3063420951, blue: 0.9661539197, alpha: 1)
}

final class AuthDesignSystem {
    func label(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = Metrics.textAlignment
        label.font = Metrics.titleFont
        return label
    }
    
    func textField(placeholder: String, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.textFieldLeftViewWidth, height: 0))
        textField.leftViewMode = .always
        textField.leftView = insetView
        textField.backgroundColor = Metrics.backgroundColor
        textField.layer.cornerRadius = Metrics.cornerRadius
        textField.layer.borderWidth = Metrics.textFieldBorderWidth
        textField.layer.borderColor = Metrics.borderColor
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.font = Metrics.standardFont
        return textField
    }
    
    func button(text: String, buttonType: AuthButtonType, with action: (() -> Void)?) -> AuthButtonDecorator {
        let button = AuthButton(type: .system)
        let buttonDecorator = buttonType.button(button: button, with: action)
        buttonDecorator.layer.cornerRadius = Metrics.cornerRadius
        buttonDecorator.layer.borderWidth = Metrics.buttonBorderWidth
        buttonDecorator.layer.borderColor = Metrics.borderColor
        buttonDecorator.backgroundColor = Metrics.backgroundColor
        let title = NSAttributedString(string: text, attributes:
                                        [NSAttributedString.Key.foregroundColor: Metrics.fontColor,
                                         NSAttributedString.Key.font: Metrics.standardFont])
        buttonDecorator.setAttributedTitle(title, for: .normal)
        buttonDecorator.isUserInteractionEnabled = true
        return buttonDecorator
    }
    
    func forgotPasswordButton(text: String, buttonType: AuthButtonType, with action: (() -> Void)?) -> AuthButtonDecorator {
        let button = AuthButton(type: .system)
        let buttonDecorator = buttonType.button(button: button, with: action)
        let title = NSAttributedString(string: text, attributes:
                                        [NSAttributedString.Key.foregroundColor: Metrics.forgotPasswordFontColor,
                                         NSAttributedString.Key.font: Metrics.standardFont])
        buttonDecorator.setAttributedTitle(title, for: .normal)
        buttonDecorator.isUserInteractionEnabled = true
        return buttonDecorator
    }
}
