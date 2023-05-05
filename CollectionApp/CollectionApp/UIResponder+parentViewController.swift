//
//  UIResponder+parentViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
