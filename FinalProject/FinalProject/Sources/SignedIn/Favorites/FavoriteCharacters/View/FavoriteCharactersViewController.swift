//
//  FavoriteCharactersViewController.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    static let charactersEmptyTitle = "Избранные персонажи отсутствуют"
    static let charactersEmptyTitleEdgeInset = 50
    static let font = UIFont.systemFont(ofSize: 24)
}

final class FavoriteCharactersViewController: UIViewController {
    private let charactersView: CharactersView
    private var charactersCountLabel: UILabel
    private var presenter: IFavoriteCharactersPresenter?
    
    init() {
        self.charactersView = CharactersView()
        self.charactersCountLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
        self.configure()
    }
    
    func setPresenter(_ presenter: IFavoriteCharactersPresenter) {
        self.presenter = presenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.loadFavoritesCharacters()
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with characters: [Character]) {
        self.charactersView.update(with: characters)
        self.charactersCountLabel.isHidden = !characters.isEmpty
    }
    
    func update(with images: [String: UIImage?]) {
        self.charactersView.update(with: images)
    }
}

private extension FavoriteCharactersViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        self.configureCharactersView()
        self.configureLocationsCountLabel()
    }
    
    func configureCharactersView() {
        self.view.addSubview(self.charactersView)
        self.charactersView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        self.charactersView.configureLayout(with: self.view.frame.height)
        self.configureCharactersViewHandlers()
    }
    
    func configureCharactersViewHandlers() {
        self.charactersView.cellTapHandler = { [weak self] characterId in
            self?.presenter?.openCharacter(with: characterId)
        }
    }
    
    func configureLocationsCountLabel() {
        self.view.addSubview(self.charactersCountLabel)
        self.charactersCountLabel.snp.makeConstraints({ make in
            make.edges.equalToSuperview().inset(Metrics.charactersEmptyTitleEdgeInset)
        })
        self.charactersCountLabel.isHidden = true
        self.charactersCountLabel.textAlignment = .center
        self.charactersCountLabel.numberOfLines = 0
        self.charactersCountLabel.text = Metrics.charactersEmptyTitle
        self.charactersCountLabel.font = Metrics.font
    }
}
