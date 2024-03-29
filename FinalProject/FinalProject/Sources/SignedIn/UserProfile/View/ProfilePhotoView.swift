//
//  ProfilePhotoView.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit

private enum Metrics {
    static let defaultProfileImage = UIImage(systemName: "person")?.withTintColor(Theme.tintColor).withRenderingMode(.alwaysOriginal)
    static let editingModeImage = UIImage(systemName: "photo")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
    static let editModeBackgroundColor = Theme.itemsBackgroundColor.withAlphaComponent(0.8)
    static let normalBackgroundColor = UIColor.color(light: .lightGray, dark: .darkGray)
    static let cornerRadius: CGFloat = 70
}

final class ProfilePhotoView: UIView {
    var profileImageTapped: (() -> Void)?
    private var photoImageView: UIImageView
    private var editingCurtainImageView: UIImageView
    private var activityView: ActivityView?
    
    init() {
        self.editingCurtainImageView = UIImageView()
        self.photoImageView = UIImageView()
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func image() -> UIImage? {
        if self.photoImageView.image == Metrics.defaultProfileImage {
            return nil
        }
        return self.photoImageView.image
    }

    func setEditing(_ isEditing: Bool) {
        self.editingCurtainImageView.alpha = isEditing ? 1 : 0
    }
    
    func update(with image: UIImage?) {
        let image = image == nil ? Metrics.defaultProfileImage : image
        self.photoImageView.image = image?.withRenderingMode(.alwaysOriginal)
        self.activityView?.stopAnimating()
    }
}

private extension ProfilePhotoView {
    func configure() {
        self.configurePhotoImageView()
        self.configureEditingCurtainView()
        self.activityView = ActivityView(superview: self.photoImageView)
        self.activityView?.startAnimating()
    }
    
    func configurePhotoImageView() {
        self.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.photoImageView.clipsToBounds = true
        self.photoImageView.layer.cornerRadius = Metrics.cornerRadius
        self.photoImageView.isUserInteractionEnabled = true
        self.update(with: Metrics.defaultProfileImage)
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.backgroundColor = Metrics.normalBackgroundColor
    }
    
    func configureEditingCurtainView() {
        self.photoImageView.addSubview(self.editingCurtainImageView)
        self.editingCurtainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.editingCurtainImageView.backgroundColor = Metrics.editModeBackgroundColor
        self.editingCurtainImageView.image = Metrics.editingModeImage
        self.editingCurtainImageView.contentMode = .scaleAspectFit
        self.editingCurtainImageView.alpha = 0
        self.editingCurtainImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.editingCurtainImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(_ sender: UIImageView) {
        self.profileImageTapped?()
    }
}
