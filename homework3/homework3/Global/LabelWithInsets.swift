//
//  LabelWithInsets.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import Foundation
import UIKit
import SnapKit

fileprivate enum Inset {
    static let defaultEdgeInset: CGFloat = 10
}

class LabelWithInsets: UILabel {
    var labelHeightConstraint: Constraint?
    var inset: CGFloat = Inset.defaultEdgeInset
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)))
    }
    
    func applyHeightToPresentAllText() {
        self.sizeToFit()
        self.numberOfLines = 0
        let doubleInset = 2 * inset
        let label: LabelWithInsets = LabelWithInsets(frame: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: self.frame.size.width - doubleInset,
                                                                   height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        labelHeightConstraint?.deactivate()
        self.snp.makeConstraints { make in
            labelHeightConstraint = make.height.equalTo(label.frame.height + doubleInset).constraint
        }
    }
}
