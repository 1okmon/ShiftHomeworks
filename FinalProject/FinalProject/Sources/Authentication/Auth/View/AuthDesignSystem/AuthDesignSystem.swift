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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        if isSecure {
            textField.textContentType = .oneTimeCode
        }
        textField.font = Metrics.standardFont
        return textField
    }
    
    func button(with text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Metrics.cornerRadius
        button.layer.borderWidth = Metrics.buttonBorderWidth
        button.layer.borderColor = Metrics.borderColor
        button.backgroundColor = Metrics.backgroundColor
        let title = NSAttributedString(string: text, attributes:
                                        [NSAttributedString.Key.foregroundColor: Metrics.fontColor,
                                         NSAttributedString.Key.font: Metrics.standardFont])
        button.setAttributedTitle(title, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }
    
    func forgotPasswordButton(with text: String) -> UIButton {
        let button = UIButton(type: .system)
        let title = NSAttributedString(string: text, attributes:
                                        [NSAttributedString.Key.foregroundColor: Metrics.forgotPasswordFontColor,
                                         NSAttributedString.Key.font: Metrics.standardFont])
        button.setAttributedTitle(title, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }
    
    func alert(title: String, message: String, buttonTitles: [String], buttonActions: [((UIAlertAction) -> Void)?] = []) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for buttonId in 0 ..< buttonTitles.count {
            let buttonAction = buttonId < buttonActions.count ? buttonActions[buttonId] : nil
            alert.addAction(UIAlertAction(title: buttonTitles[buttonId],
                                          style: UIAlertAction.Style.default,
                                          handler: buttonAction))
        }
        return alert
    }
}
