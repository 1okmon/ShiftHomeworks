//
//  IKeyboardSupportedView.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit
private enum Metrics {
    static let animateDuration = 0.2
    static let backgroundColor = Theme.backgroundColor
}

class KeyboardSupportedView: UIView {
    var scrollView = UIScrollView()
    private var firsResponderTextField: UITextField?
    private var textFields: [UITextField]
    
    init(textFields: [UITextField]) {
        self.textFields = textFields
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
        self.scrollView.contentInset.bottom = keyboardHeight
    }
    
    func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
    }
    
    func configureContentViewBottomConstraint(bottomView: UIView?) {
        bottomView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
}

private extension KeyboardSupportedView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureScrollView()
        textFields.forEach { self.configureDelegate(at: $0) }
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
    
    func configureDelegate(at textField: UITextField) {
        textField.delegate = self
    }
    
    func verticalOffset(with keyboardHeight: CGFloat) -> CGFloat {
        let viewHeight = self.frame.height
        let halfHeightOfVisibleView = Int((viewHeight - keyboardHeight)/2)
        self.textFields.forEach {
            if $0.isEditing {
                self.firsResponderTextField = $0
            }
        }
        guard let firsResponderTextField = self.firsResponderTextField else { return 0 }
        let textFieldY = Int((firsResponderTextField.frame.origin.y))
        let offset = textFieldY > halfHeightOfVisibleView ? textFieldY - halfHeightOfVisibleView : halfHeightOfVisibleView - textFieldY
        return CGFloat(offset)
    }
}

extension KeyboardSupportedView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textFields.last == textField {
            textField.resignFirstResponder()
            keyboardWillHide()
            return true
        }
        if let index = textFields.firstIndex(where: { field in
            field == textField
        }) {
            textFields[index + 1].becomeFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
