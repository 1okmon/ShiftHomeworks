//
//  LocationDetailsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
}

final class LocationDetailsViewController: UIViewController, IObserver {
    var id: UUID
    private let viewModel: ILocationDetailsViewModel
    private let locationDetailsView: LocationDetailsView
    
    init(viewModel: ILocationDetailsViewModel) {
        self.viewModel = viewModel
        self.locationDetailsView = LocationDetailsView()
        self.id = UUID()
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<T>(with value: T) {
        DispatchQueue.main.async {
            if let isFavorite = value as? Bool {
                self.navigationItem.rightBarButtonItem?.image = Icon.Favorite.image(isFavorite)
            }
            if let characters = value as? [Character] {
                self.locationDetailsView.update(with: characters)
            } else if let locationDetails = value as? LocationDetails {
                self.navigationItem.title = locationDetails.name
                self.locationDetailsView.update(with: locationDetails)
            } else if let images = value as? [String: UIImage?] {
                self.locationDetailsView.update(with: images)
            }
        }
    }
}

private extension LocationDetailsViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        let favoriteButton = UIBarButtonItem(image: Icon.Favorite.image(),
                                             style: .plain,
                                             target: self,
                                             action: #selector(favoritesButtonTapped(_:)))
        self.navigationItem.setRightBarButton(favoriteButton, animated: true)
        configureLocationDetailsView()
    }
    
    @objc func favoritesButtonTapped(_ sender: UIBarButtonItem) {
        self.viewModel.switchAddedInFavourites()
    }
    
    func configureLocationDetailsView() {
        self.view.addSubview(self.locationDetailsView)
        self.locationDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureLocationDetailsViewHandlers()
    }
    
    func configureLocationDetailsViewHandlers() {
        self.locationDetailsView.residentsButtonTapHandler = { [weak self] in
            self?.viewModel.loadCharacters()
        }
        self.locationDetailsView.cellTapHandler = { [weak self] id in
            self?.viewModel.openCharacter(with: id)
        }
    }
}
