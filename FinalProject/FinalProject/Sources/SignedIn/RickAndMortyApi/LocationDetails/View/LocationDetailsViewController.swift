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
    private let viewModel: LocationDetailsViewModel
    private let locationDetailsView: LocationDetailsView
    
    init(viewModel: LocationDetailsViewModel) {
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
        configureLocationDetailsView()
    }
    
    func configureLocationDetailsView() {
        self.view.addSubview(self.locationDetailsView)
        self.locationDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureLocationDetailsViewHandlers()
    }
    
    func configureLocationDetailsViewHandlers() {
        self.locationDetailsView.cellTapHandler = { [weak self] id in
            self?.viewModel.openCharacter(with: id)
        }
    }
}
