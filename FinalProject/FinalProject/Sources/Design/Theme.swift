//
//  Theme.swift
//  FinalProject
//
//  Created by 1okmon on 29.05.2023.
//

import UIKit

enum Theme {
    static let backgroundColor = UIColor.color(light: .white, dark: .black)
    static let collectionViewBackgroundColor = UIColor.color(light: .lightGray, dark: .systemGray6)
    static let textColor = UIColor.color(light: .black, dark: .white)
    static let tintColor = UIColor.color(light: .black, dark: .white)
    static let itemsBackgroundColor = UIColor.color(light: .white, dark: .darkGray)
    static let placeholderColor = UIColor.color(light: .gray, dark: .lightGray)
    static let separatorColor = UIColor.color(light: .gray, dark: .lightGray)
    static var borderCgColor: CGColor { UIColor.color(light: .black, dark: .lightGray).cgColor }
}

private extension UIColor {
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
}
