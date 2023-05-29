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
    static let animateDuration = 0.2
    static let activityViewBackgroundColor = UIColor.white.withAlphaComponent(0.8)
    static let activityIndicatorVerticalOffset = -50
}

class AuthView: UIView {
    var alertHandler: ((String, String, String) -> Void)?
    private var activityView: UIView?
    private var scrollView = UIScrollView()
    private var titleLabel: UILabel
    private var firsResponderTextField: UITextField?
    private var textFields: [UITextField]
    private var buttons: [UIButton]
    
    init(titleLabel: UILabel, textFields: [UITextField], buttons: [UIButton]) {
        self.titleLabel = titleLabel
        self.textFields = textFields
        self.buttons = buttons
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyboardWillShow(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: Metrics.animateDuration) {
            self.scrollView.contentOffset.y = self.verticalOffset(with: keyboardHeight)
        }
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    func showActivityIndicatory() {
        let activityView = UIView()
        activityView.backgroundColor = Metrics.activityViewBackgroundColor
        self.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configureActivityIndicatorView(for: activityView)
        self.activityView = activityView
    }
    
    func closeActivityIndicatory() {
        self.activityView?.subviews.forEach({ $0.removeFromSuperview() })
        self.activityView?.removeFromSuperview()
    }
    
    func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
    }
    
    func showAlert(of type: AuthResult) {
        showAlert(with: type.title, type.message, buttonTitle: type.buttonTitle)
    }
}

private extension AuthView {
    func configure() {
        configureScrollView()
        configureTitleLabel()
        configureTextFields()
        configureButtons()
        configureContentViewBottomConstraint(at: scrollView, bottomView: buttons.last)
    }
    
    func configureScrollView() {
        self.addSubview(scrollView)
        configureScrollViewConstraints()
    }
    
    func configureScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
    }
    
    func configureContentViewBottomConstraint(at scrollView: UIScrollView, bottomView: UIView?) {
        bottomView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    func configureTitleLabel() {
        self.scrollView.addSubview(titleLabel)
        configureTitleLabelConstraints()
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.titleTopOffset)
            make.horizontalEdges.equalTo(self)
        }
    }
    
    func configureTextFields() {
        for textFieldId in 0..<textFields.count {
            let topOffset = textFieldId == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            let upperView = textFieldId == 0 ? titleLabel : textFields[textFieldId - 1]
            configure(textFields[textFieldId], under: upperView, with: Metrics.height, with: topOffset, with: Metrics.horizontalInset)
            configureDelegate(at: textFields[textFieldId])
        }
    }
    
    func configureDelegate(at textField: UITextField) {
        textField.delegate = self
    }
    
    func configureButtons() {
        for buttonId in 0..<buttons.count {
            let topOffset = buttonId == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            guard let upperView = buttonId == 0 ? textFields.last : buttons[buttonId - 1] else { return }
            configure(buttons[buttonId], under: upperView, with: Metrics.height, with: topOffset, with: Metrics.horizontalInset)
        }
    }
    
    func configure(_ view: UIView, under upperView: UIView, with height: Int, with topOffset: Int, with horizontalInset: Int) {
        self.scrollView.addSubview(view)
        configureConstraints(at: view,
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
    
    func verticalOffset(with keyboardHeight: CGFloat) -> CGFloat {
        let viewHeight = self.frame.height
        let halfHeightOfVisibleView = Int((viewHeight - keyboardHeight)/2)
        textFields.forEach {
            if $0.isEditing {
                firsResponderTextField = $0
            }
        }
        guard let firsResponderTextField = firsResponderTextField else { return 0 }
        let textFieldY = Int((firsResponderTextField.frame.origin.y))
        let offset = textFieldY > halfHeightOfVisibleView ? textFieldY - halfHeightOfVisibleView : halfHeightOfVisibleView - textFieldY
        return CGFloat(offset)
    }
    
    func showAlert(with alertTitle: String, _ alertMessage: String, buttonTitle: String) {
        guard let alertHandler = alertHandler else { return }
        alertHandler(alertTitle, alertMessage, buttonTitle)
    }
    
    private func configureActivityIndicatorView(for view: UIView) {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(Metrics.activityIndicatorVerticalOffset)
        }
        activityIndicatorView.startAnimating()
    }
}

extension AuthView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textFields.last == textField {
            textField.resignFirstResponder()
            keyboardWillHide()
            return true
        }
        if let index = textFields.firstIndex(where: { field in
            field == textField
        }) {
            textFields[index+1].becomeFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
