//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension ProfileViewController {
    func configure() {
        self.view.backgroundColor = .white
        configureProfileView()
    }
    
    func configureProfileView() {
        self.view.addSubview(profileView)
        self.profileView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
