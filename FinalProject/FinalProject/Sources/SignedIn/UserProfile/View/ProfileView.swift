//
//  ProfileView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

private enum Metrics {
    static let font = UIFont.systemFont(ofSize: 22)
    
    enum Button {
        static let normalImage = UIImage(systemName: "pencil.circle")?.withTintColor(Theme.tintColor).withRenderingMode(.alwaysOriginal)
        static let editingImage = UIImage(systemName: "checkmark.circle")?.withTintColor(Theme.tintColor).withRenderingMode(.alwaysOriginal)
        static let edgeInset = 15
        static let height = 35
        static let width = 80
        static let signOutTitle = "Выйти"
        static let textColor = UIColor.systemBlue
    }
    
    enum Row {
        static let horizontalInset = 15
        static let beforeSectionOffset = 120
        static let inSectionOffset = 10
        static let height = 50
        static let labelWidth = 120
        static let cornerRadius: CGFloat = 10
        static let normalBackgroundColor = Theme.backgroundColor
        static let editingBackgroundColor = Theme.collectionViewBackgroundColor
        static let leftViewWidth = 20
        
        enum Title {
            static let firstName = "Имя:"
            static let lastName = "Фамилия:"
        }
    }
    static let backgroundColor = Theme.backgroundColor
}

private typealias Row = (label: UILabel, textField: UITextField)

final class ProfileView: UIView {
    var signOutTapHandler: (() -> Void)?
    var saveTapHandler: ((UserData) -> Void)?
    private var activityView: ActivityView?
    private let firstNameRow: Row
    private let lastNameRow: Row
    private let editButton: UIButton
    private let signOutButton: UIButton
    private var isEditing: Bool
    
    override init(frame: CGRect) {
        self.editButton = UIButton(type: .system)
        self.firstNameRow = (UILabel(), UITextField())
        self.lastNameRow = (UILabel(), UITextField())
        self.signOutButton = UIButton(type: .system)
        self.isEditing = false
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with userData: UserData) {
        self.firstNameRow.textField.text = userData.firstName
        self.lastNameRow.textField.text = userData.lastName
        self.activityView?.stopAnimating()
    }
}

private extension ProfileView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureEditButton()
        configureFirstName()
        configureLastName()
        configureSignOutButton()
        self.activityView = ActivityView(superview: self)
        self.activityView?.startAnimating()
    }
    
    func configureSignOutButton() {
        self.addSubview(self.signOutButton)
        self.signOutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Metrics.Button.edgeInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.Button.width)
            make.height.equalTo(Metrics.Button.height)
        }
        self.signOutButton.setTitle(Metrics.Button.signOutTitle, for: .normal)
        self.signOutButton.titleLabel?.font = Metrics.font
        self.signOutButton.setTitleColor(Metrics.Button.textColor, for: .normal)
        self.signOutButton.addTarget(self, action: #selector(signOutButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func signOutButtonTapped(_ sender: UIButton) {
        self.signOutTapHandler?()
    }
    
    func configureEditButton() {
        self.addSubview(self.editButton)
        self.editButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(Metrics.Button.edgeInset)
            make.height.width.equalTo(Metrics.Button.height)
        }
        self.editButton.setImage(Metrics.Button.normalImage, for: .normal)
        self.editButton.contentHorizontalAlignment = .fill
        self.editButton.contentVerticalAlignment = .fill
        self.editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.firstNameRow.textField.isUserInteractionEnabled = !self.isEditing
            self.lastNameRow.textField.isUserInteractionEnabled = !self.isEditing
            if self.isEditing {
                self.editButton.setImage(Metrics.Button.normalImage, for: .normal)
                self.firstNameRow.textField.backgroundColor = Metrics.Row.normalBackgroundColor
                self.lastNameRow.textField.backgroundColor = Metrics.Row.normalBackgroundColor
                let userData = UserData(firstName: self.firstNameRow.textField.text,
                                        lastName: self.lastNameRow.textField.text)
                self.saveTapHandler?(userData)
            } else {
                self.editButton.setImage(Metrics.Button.editingImage, for: .normal)
                self.firstNameRow.textField.backgroundColor = Metrics.Row.editingBackgroundColor
                self.lastNameRow.textField.backgroundColor = Metrics.Row.editingBackgroundColor
            }
            self.isEditing = !self.isEditing
        }
    }
    
    func configureFirstName() {
        configure(self.firstNameRow)
        self.firstNameRow.label.text = Metrics.Row.Title.firstName
    }
    
    func configureLastName() {
        configure(self.lastNameRow, under: self.firstNameRow.label)
        self.lastNameRow.label.text = Metrics.Row.Title.lastName
    }
    
    func configure(_ row: Row, under upperView: UIView? = nil) {
        self.addSubview(row.label)
        self.addSubview(row.textField)
        row.label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Metrics.Row.horizontalInset)
            if let upperView = upperView {
                make.top.equalTo(upperView.snp.bottom).offset(Metrics.Row.inSectionOffset)
            } else {
                make.top.equalToSuperview().offset(Metrics.Row.beforeSectionOffset)
            }
            make.height.equalTo(Metrics.Row.height)
            make.width.equalTo(Metrics.Row.labelWidth)
        }
        row.textField.snp.makeConstraints { make in
            make.leading.equalTo(row.label.snp.trailing).inset(Metrics.Row.horizontalInset)
            make.trailing.equalToSuperview().inset(Metrics.Row.horizontalInset)
            make.top.equalTo(row.label.snp.top)
            make.height.equalTo(Metrics.Row.height)
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.Row.leftViewWidth, height: 0))
        row.textField.leftViewMode = .always
        row.textField.leftView = view
        row.textField.layer.cornerRadius = Metrics.Row.cornerRadius
        row.textField.backgroundColor = Metrics.Row.normalBackgroundColor
        row.textField.isUserInteractionEnabled = false
        row.label.font = Metrics.font
        row.textField.font = Metrics.font
    }
}
