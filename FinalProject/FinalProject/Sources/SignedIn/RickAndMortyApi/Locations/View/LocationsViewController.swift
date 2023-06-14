//
//  LocationsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    static let reloadActionTitle = "Повторить"
}

class LocationsViewController: UIViewController, IObserver {
    let id: UUID
    private let viewModel: ILocationsViewModel
    private let locationView: LocationsView
    
    init(viewModel: ILocationsViewModel) {
        self.id = UUID()
        self.locationView = LocationsView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<T>(with value: T) {
        if let errorCode = value as? NetworkResponseCode {
            let alert = AlertBuilder()
                .setFieldsToShowAlert(of: errorCode)
                .addAction(UIAlertAction(title: Metrics.reloadActionTitle,
                                         style: .default,
                                         handler: { [weak self] _ in
                    self?.viewModel.reload()
                }))
                .build()
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            return
        }
        guard let result = value as? (locations: [Location], isFirstPage: Bool, isLastPage: Bool) else { return }
        locationView.update(with: result.locations,
                            isFirstPage: result.isFirstPage,
                            isLastPage: result.isLastPage)
    }
}

private extension LocationsViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        configureLocationView()
    }
    
    func configureLocationView() {
        self.view.addSubview(self.locationView)
        self.locationView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureLocationViewTapHandlers()
    }
    
    func configureLocationViewTapHandlers() {
        self.locationView.nextPageTapHandler = { [weak self] in
            self?.viewModel.loadNextPage()
        }
        self.locationView.previousPageTapHandler = { [weak self] in
            self?.viewModel.loadPreviousPage()
        }
        self.locationView.cellTapHandler = { [weak self] locationId in
            self?.viewModel.openLocation(with: locationId)
        }
    }
}
