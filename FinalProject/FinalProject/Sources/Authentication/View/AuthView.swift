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
}

final class AuthView: UIView {
    private var scrollView = UIScrollView()
    private var titleLabel: UILabel
    private var firsResponderTextField: UITextField?
    private var textFields: [UITextField]
    private var buttons: [AuthButtonDecorator]
    private var designSystem = AuthDesignSystem()
    
    init(titleLabel: UILabel, textFields: [UITextField], buttons: [AuthButtonDecorator]) {
        self.titleLabel = titleLabel
        self.textFields = textFields
        self.buttons = buttons
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func verticalOffset(with keyboardHeight: CGFloat) -> CGFloat {
        let viewHeight = self.frame.height
        let halfHeightOfVisibleView = Int((viewHeight - keyboardHeight)/2)
        for textField in textFields {
            if(textField.isEditing) {
                firsResponderTextField = textField
            }
        }
        guard let firsResponderTextField = firsResponderTextField else { return 0 }
        let textFieldY = Int((firsResponderTextField.frame.origin.y))
        let offset = textFieldY > halfHeightOfVisibleView ? textFieldY - halfHeightOfVisibleView : halfHeightOfVisibleView - textFieldY
        return CGFloat(offset)
    }
    
}

private extension AuthView {
    func configure() {
        configure(scrollView: scrollView)
        configure(titleLabel: titleLabel)
        configure(textFields: textFields)
        configure(buttons: buttons)
        configureContentViewBottomConstraint(at: scrollView, bottomView: buttons.last)
    }
    
    func configure(scrollView: UIScrollView) {
        self.addSubview(scrollView)
        configureConstraints(at: scrollView)
    }
    
    func configureConstraints(at scrollView: UIScrollView) {
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
    
    func configure(titleLabel: UILabel) {
        self.scrollView.addSubview(titleLabel)
        configureConstraints(at: titleLabel)
    }
    
    func configureConstraints(at titleLabel: UILabel) {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.titleTopOffset)
            make.horizontalEdges.equalTo(self)
        }
    }
    
    func configure(textFields: [UITextField]) {
        for i in 0..<textFields.count {
            let topOffset = i == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            let upperView = i == 0 ? titleLabel : textFields[i - 1]
            configure(view: textFields[i], upperView: upperView, height: Metrics.height, topOffset: topOffset, horizontalInset: Metrics.horizontalInset)
        }
    }
    
    
    func configure(buttons: [UIButton]) {
        for i in 0..<buttons.count {
            let topOffset = i == 0 ? Metrics.beforeSectionTopOffset : Metrics.inSectionTopOffset
            guard let upperView = i == 0 ? textFields.last : buttons[i - 1] else { return }
            
            configure(view: buttons[i], upperView: upperView, height: Metrics.height, topOffset: topOffset, horizontalInset: Metrics.horizontalInset)
        }
    }
    
    func configure(view: UIView, upperView: UIView, height: Int, topOffset: Int, horizontalInset:Int) {
        self.scrollView.addSubview(view)
        configureConstraints(at: view,
                             under: upperView,
                             height: height,
                             topOffset: topOffset,
                             horizontalInset: horizontalInset)
    }
    
    func configureConstraints(at view: UIView, under upperView: UIView, height: Int, topOffset: Int, horizontalInset: Int) {
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(horizontalInset)
            make.top.equalTo(upperView.snp.bottom).offset(topOffset)
            make.height.equalTo(height)
        }
    }
}

