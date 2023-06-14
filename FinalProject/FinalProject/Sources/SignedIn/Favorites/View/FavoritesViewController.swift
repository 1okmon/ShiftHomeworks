//
//  FavoritesViewController.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

final class FavoritesViewController: UIViewController {
    private let favoriteView: FavoritesView
    private let viewModel: IFavoritesViewModel
    
    init(viewModel: IFavoritesViewModel) {
        self.viewModel = viewModel
        self.favoriteView = FavoritesView()
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.favoriteView.configureContentMode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FavoritesViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        configureFavoriteView()
    }
    
    func configureFavoriteView() {
        self.view.addSubview(self.favoriteView)
        self.favoriteView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureFavoriteViewHandlers()
    }
    
    func configureFavoriteViewHandlers() {
        self.favoriteView.locationsTapHandler = {
            self.viewModel.goToLocations()
        }
        self.favoriteView.charactersTapHandler = {
            self.viewModel.goToCharacters()
        }
    }
}
