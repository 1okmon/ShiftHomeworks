//
//  UIColor+themeColor.swift
//  FinalProject
//
//  Created by 1okmon on 15.06.2023.
//

import UIKit

extension UIColor {
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
