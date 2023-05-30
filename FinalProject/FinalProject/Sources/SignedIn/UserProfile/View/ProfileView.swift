//
//  ProfileView.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class ProfileView: UIView {
    private var userImageView = UIImageView()
    private var emailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProfileView {
    func configure() {
        configureUserImageView()
        configureEmailLabel()
    }
    
    func configureUserImageView() {
        self.addSubview(userImageView)
        userImageView.image = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
        userImageView.contentMode = .scaleAspectFit
        userImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
    }
    
    func configureEmailLabel() {
        self.addSubview(emailLabel)
        emailLabel.backgroundColor = .systemPink
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
    }
}
