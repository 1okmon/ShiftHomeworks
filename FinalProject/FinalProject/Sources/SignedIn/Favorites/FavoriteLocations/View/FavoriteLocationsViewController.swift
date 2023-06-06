//
//  FavoriteLocationsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import Foundation

final class FavoriteLocationsViewController: LocationsViewController {
    private let viewModel: FavoriteLocationsViewModel
    
    init(viewModel: FavoriteLocationsViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.reloadLocations()
    }
}
