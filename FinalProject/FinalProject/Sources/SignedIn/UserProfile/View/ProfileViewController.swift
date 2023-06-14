//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

final class ProfileViewController: UIViewController {
    private var profileView = ProfileView()
    private var presenter: ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func setPresenter(_ presenter: ProfilePresenter) {
        self.presenter = presenter
    }
    
    func update(with userData: UserData) {
        self.profileView.update(with: userData)
    }
}

private extension ProfileViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        configureProfileView()
    }
    
    func configureProfileView() {
        self.view.addSubview(profileView)
        self.profileView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureProfileViewHandlers()
    }
    
    func configureProfileViewHandlers() {
        self.profileView.saveTapHandler = { [weak self] userData in
            self?.presenter?.save(userData: userData)
        }
        self.profileView.signOutTapHandler = { [weak self] in
            self?.presenter?.signOut()
        }
    }
}
