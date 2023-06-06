//
//  FavoriteCharactersViewController.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

final class FavoriteCharactersViewController: UIViewController {
    let charactersView: CharactersView
    var presenter: IFavoriteCharactersPresenter?
    
    init() {
        self.charactersView = CharactersView()
        super.init(nibName: nil, bundle: nil)
        configure()
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
    }
    
    func update(with images: [String: UIImage?]) {
        self.charactersView.update(with: images)
    }
}

private extension FavoriteCharactersViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        configureCharactersView()
    }
    
    func configureCharactersView() {
        self.view.addSubview(self.charactersView)
        self.charactersView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        self.charactersView.configureLayout(with: self.view.frame.height)
        configureCharactersViewHandlers()
    }
    
    func configureCharactersViewHandlers() {
        self.charactersView.cellTapHandler = { [weak self] characterId in
            self?.presenter?.openCharacter(with: characterId)
        }
    }
}
