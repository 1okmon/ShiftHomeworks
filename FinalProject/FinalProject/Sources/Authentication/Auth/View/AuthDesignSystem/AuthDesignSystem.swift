//
//  Subviews.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit

private enum Metrics {
    static let cornerRadius: CGFloat = 15
    static let textFieldBorderWidth: CGFloat = 1
    static let buttonBorderWidth: CGFloat = 2
    static let textFieldLeftViewWidth: CGFloat = 15
    static let backgroundColor = Theme.itemsBackgroundColor
    static let textAlignment: NSTextAlignment = .center
    static let standardFont = UIFont.systemFont(ofSize: 20)
    static let titleFont = UIFont.systemFont(ofSize: 30)
    static let fontColor = Theme.textColor
    static let placeholderColor = Theme.placeholderColor
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
    
    func textField(placeholderText: String, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.textFieldLeftViewWidth, height: 0))
        textField.leftViewMode = .always
        textField.leftView = insetView
        textField.backgroundColor = Metrics.backgroundColor
        textField.layer.cornerRadius = Metrics.cornerRadius
        textField.layer.borderWidth = Metrics.textFieldBorderWidth
        textField.layer.borderColor = Theme.borderCgColor
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: Metrics.placeholderColor]
        )
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
        button.layer.borderColor = Theme.borderCgColor
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
}
