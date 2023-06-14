//
//  FavoriteLocationsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

private enum Metrics {
    static let locationsEmptyTitle = "Избранные локации отсутствуют"
    static let locationsEmptyTitleEdgeInset = 50
    static let font = UIFont.systemFont(ofSize: 24)
}

final class FavoriteLocationsViewController: LocationsViewController {
    private let viewModel: IFavoriteLocationsViewModel
    private var locationsCountLabel: UILabel
    
    override func update<T>(with value: T) {
        super.update(with: value)
        guard let result = value as? (locations: [Location], Bool, Bool) else { return }
        self.locationsCountLabel.isHidden = !result.locations.isEmpty
    }
    
    init(viewModel: IFavoriteLocationsViewModel) {
        self.viewModel = viewModel
        self.locationsCountLabel = UILabel()
        super.init(viewModel: viewModel)
        self.configureLocationsCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.reloadLocations()
    }
}

private extension FavoriteLocationsViewController {
    func configureLocationsCountLabel() {
        self.view.addSubview(self.locationsCountLabel)
        self.locationsCountLabel.snp.makeConstraints({ make in
            make.edges.equalToSuperview().inset(Metrics.locationsEmptyTitleEdgeInset)
        })
        self.locationsCountLabel.isHidden = true
        self.locationsCountLabel.textAlignment = .center
        self.locationsCountLabel.numberOfLines = 0
        self.locationsCountLabel.text = Metrics.locationsEmptyTitle
        self.locationsCountLabel.font = Metrics.font
    }
}
