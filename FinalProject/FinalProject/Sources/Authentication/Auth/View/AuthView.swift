//
//  AuthView.swift
//  RickAndMortyWiki
//
//  Created by 1okmon on 15.05.2023.
//

import UIKit
import SnapKit

private enum Metrics {
    static let titleTopOffset = 30
    static let height = 50
    static let beforeSectionTopOffset = 150
    static let inSectionTopOffset = 10
    static let horizontalInset = 50
}

class AuthView: KeyboardSupportedView {
    private var activityView: ActivityView?
    private var titleLabel: UILabel
    private var textFields: [UITextField]
    private var buttons: [UIButton]
    
    init(titleLabel: UILabel, textFields: [UITextField], buttons: [UIButton]) {
        self.titleLabel = titleLabel
        self.textFields = textFields
        self.buttons = buttons
        super.init(textFields: textFields)
        self.configure()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCgColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showActivityIndicator() {
        self.activityView?.startAnimating()
    }
    
    func closeActivityIndicator() {
        self.activityView?.stopAnimating()
    }
}

private extension AuthView {
    func configure() {
        self.configureTitleLabel()
        self.configureTextFields()
        self.configureButtons()
        self.configureContentViewBottomConstraint(bottomView: self.buttons.last)
        self.activityView = ActivityView(superview: self)
    }
    
    func configureTitleLabel() {
        self.scrollView.addSubview(self.titleLabel)
        self.configureTitleLabelConstraints()
    }
    
    func configureTitleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.titleTopOffset)
            make.horizontalEdges.equalTo(self)
        }
    }
    
    func configureTextFields() {
        for textFieldId in 0..<self.textFields.count {
            let topOffset = textFieldId == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            let upperView = textFieldId == 0 ? self.titleLabel : self.textFields[textFieldId - 1]
            self.configure(self.textFields[textFieldId], under: upperView, with: Metrics.height, with: topOffset, with: Metrics.horizontalInset)
        }
    }
    
    func configureButtons() {
        for buttonId in 0..<self.buttons.count {
            let topOffset = buttonId == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            guard let upperView = buttonId == 0 ? self.textFields.last : self.buttons[buttonId - 1] else { return }
            self.configure(buttons[buttonId], under: upperView, with: Metrics.height, with: topOffset, with: Metrics.horizontalInset)
        }
    }
    
    func configure(_ view: UIView, under upperView: UIView, with height: Int, with topOffset: Int, with horizontalInset: Int) {
        self.scrollView.addSubview(view)
        self.configureConstraints(at: view,
                                  under: upperView,
                                  with: height,
                                  with: topOffset,
                                  with: horizontalInset)
    }
    
    func configureConstraints(at view: UIView, under upperView: UIView, with height: Int, with topOffset: Int, with horizontalInset: Int) {
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(horizontalInset)
            make.top.equalTo(upperView.snp.bottom).offset(topOffset)
            make.height.equalTo(height)
        }
    }
    
    func updateCgColors() {
        for textField in self.textFields {
            textField.layer.borderColor = Theme.borderCgColor
        }
        for button in self.buttons {
            button.layer.borderColor = Theme.borderCgColor
        }
    }
}
