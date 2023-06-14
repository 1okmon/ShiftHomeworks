//
//  CharacterDetailsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let favoriteButtonInset = 5
    static let favoriteButtonHeight = 50
}

final class CharacterDetailsViewController: UIViewController, IObserver {
    var id: UUID
    var dismissCompletion: (() -> Void)?
    private let viewModel: ICharacterDetailsViewModel
    private let characterDetailsView: CharacterDetailsView
    private let favoriteButton: UIButton
    
    init(viewModel: ICharacterDetailsViewModel) {
        self.id = UUID()
        self.viewModel = viewModel
        self.favoriteButton = UIButton(type: .system)
        self.characterDetailsView = CharacterDetailsView()
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismissCompletion?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<T>(with value: T) {
        if let errorCode = value as? NetworkResponseCode {
            let alert = AlertBuilder()
                .setFieldsToShowAlert(of: errorCode)
                .addAction(UIAlertAction(title: errorCode.buttonTitle, style: .default, handler: { [weak self] _ in
                    self?.viewModel.close()
                }))
                .build()
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            return
        }
        if let isFavorite = value as? Bool {
            self.favoriteButton.setImage(Icon.Favorite.image(isFavorite), for: .normal)
        }
        guard let character = value as? CharacterDetails else { return }
        self.characterDetailsView.update(with: character)
        DispatchQueue.main.async {
            self.favoriteButton.isHidden = false
        }
    }
}

private extension CharacterDetailsViewController {
    func configure() {
        self.view.addSubview(self.characterDetailsView)
        self.characterDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configureFavoriteButton()
    }
    
    func configureFavoriteButton() {
        self.view.addSubview(self.favoriteButton)
        self.favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Metrics.favoriteButtonInset)
            make.height.width.equalTo(Metrics.favoriteButtonHeight)
        }
        self.favoriteButton.setImage(Icon.Favorite.image(), for: .normal)
        self.favoriteButton.addTarget(self, action: #selector(favoritesButtonTapped(_:)), for: .touchUpInside)
        self.favoriteButton.isHidden = true
    }
    
    @objc func favoritesButtonTapped(_ sender: UIBarButtonItem) {
        self.viewModel.switchAddedInFavourites()
    }
}
