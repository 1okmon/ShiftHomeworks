//
//  ProfileView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

private enum Metrics {
    static let font = UIFont.systemFont(ofSize: 22)
    static let profileImageHeight = 200
    static let backgroundColor = Theme.backgroundColor
    
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
}

private typealias Row = (label: UILabel, textField: UITextField)

final class ProfileView: KeyboardSupportedView {
    var profileImageTapped: (() -> Void)?
    var signOutTapHandler: (() -> Void)?
    var saveTapHandler: ((UserData) -> Void)?
    private var activityView: ActivityView?
    private let firstNameRow: Row
    private let lastNameRow: Row
    private let editButton: UIButton
    private let signOutButton: UIButton
    private var isEditing: Bool
    private var profilePhotoView: ProfilePhotoView
    private var userData: UserData?
    
    init() {
        self.profilePhotoView = ProfilePhotoView()
        self.editButton = UIButton(type: .system)
        self.firstNameRow = (UILabel(), UITextField())
        self.lastNameRow = (UILabel(), UITextField())
        self.signOutButton = UIButton(type: .system)
        self.isEditing = false
        super.init(textFields: [self.firstNameRow.textField,
                                self.lastNameRow.textField])
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
    
    func update(with image: UIImage?) {
        self.profilePhotoView.update(with: image)
    }
}

// MARK: methods extension
private extension ProfileView {
    @objc func signOutButtonTapped(_ sender: UIButton) {
        self.signOutTapHandler?()
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.firstNameRow.textField.isUserInteractionEnabled = !self.isEditing
            self.lastNameRow.textField.isUserInteractionEnabled = !self.isEditing
            if self.isEditing {
                self.editButton.setImage(Metrics.Button.normalImage, for: .normal)
                self.firstNameRow.textField.backgroundColor = Metrics.Row.normalBackgroundColor
                self.lastNameRow.textField.backgroundColor = Metrics.Row.normalBackgroundColor
                self.saveIfChanged(userData: self.currentUserData())
            } else {
                self.editButton.setImage(Metrics.Button.editingImage, for: .normal)
                self.firstNameRow.textField.backgroundColor = Metrics.Row.editingBackgroundColor
                self.lastNameRow.textField.backgroundColor = Metrics.Row.editingBackgroundColor
                self.userData = self.currentUserData()
            }
            self.isEditing = !self.isEditing
            self.profilePhotoView.setEditing(self.isEditing)
        }
    }
    
    func currentUserData() -> UserData {
        UserData(firstName: self.firstNameRow.textField.text,
                 lastName: self.lastNameRow.textField.text,
                 image: self.profilePhotoView.image())
    }
    
    func saveIfChanged(userData: UserData) {
        guard self.userData?.firstName == userData.firstName,
              self.userData?.lastName == userData.lastName,
              self.userData?.image == userData.image else {
            self.userData = userData
            self.saveTapHandler?(userData)
            return
        }
    }
}

// MARK: configure extension
private extension ProfileView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureEditButton()
        configureProfilePhotoView()
        configureFirstName()
        configureLastName()
        configureSignOutButton()
        configureContentViewBottomConstraint(bottomView: self.signOutButton)
        self.activityView = ActivityView(superview: self)
        self.activityView?.startAnimating()
    }
    
    func configureProfilePhotoView() {
        self.scrollView.addSubview(self.profilePhotoView)
        self.profilePhotoView.snp.makeConstraints { make in
            make.top.equalTo(self.editButton.snp.bottom).offset(Metrics.Row.inSectionOffset)
            make.centerX.equalTo(self)
            make.height.width.equalTo(Metrics.profileImageHeight)
        }
        self.profilePhotoView.profileImageTapped = { [weak self] in
            self?.profileImageTapped?()
        }
    }
    
    func configureSignOutButton() {
        self.scrollView.addSubview(self.signOutButton)
        self.signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(Metrics.Button.edgeInset)
            make.centerX.equalTo(self)
            make.width.equalTo(Metrics.Button.width)
            make.height.equalTo(Metrics.Button.height)
        }
        self.signOutButton.setTitle(Metrics.Button.signOutTitle, for: .normal)
        self.signOutButton.titleLabel?.font = Metrics.font
        self.signOutButton.setTitleColor(Metrics.Button.textColor, for: .normal)
        self.signOutButton.addTarget(self, action: #selector(signOutButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureEditButton() {
        self.scrollView.addSubview(self.editButton)
        self.editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.Button.edgeInset)
            make.trailing.equalTo(self).inset(Metrics.Button.edgeInset)
            make.height.width.equalTo(Metrics.Button.height)
        }
        self.editButton.setImage(Metrics.Button.normalImage, for: .normal)
        self.editButton.contentHorizontalAlignment = .fill
        self.editButton.contentVerticalAlignment = .fill
        self.editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureFirstName() {
        configure(self.firstNameRow, under: self.profilePhotoView)
        self.firstNameRow.label.text = Metrics.Row.Title.firstName
    }
    
    func configureLastName() {
        configure(self.lastNameRow, under: self.firstNameRow.label)
        self.lastNameRow.label.text = Metrics.Row.Title.lastName
    }
    
    func configure(_ row: Row, under upperView: UIView) {
        self.scrollView.addSubview(row.label)
        self.scrollView.addSubview(row.textField)
        row.label.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(Metrics.Row.horizontalInset)
            make.top.equalTo(upperView.snp.bottom).offset(Metrics.Row.inSectionOffset)
            make.height.equalTo(Metrics.Row.height)
            make.width.equalTo(Metrics.Row.labelWidth)
        }
        row.textField.snp.makeConstraints { make in
            make.leading.equalTo(row.label.snp.trailing).inset(Metrics.Row.horizontalInset)
            make.trailing.equalTo(self).inset(Metrics.Row.horizontalInset)
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
