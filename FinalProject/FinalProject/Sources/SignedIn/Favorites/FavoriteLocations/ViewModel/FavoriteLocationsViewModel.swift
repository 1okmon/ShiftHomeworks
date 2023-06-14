//
//  FavoriteLocationsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

import Foundation

final class FavoriteLocationsViewModel: LocationsViewModel, IFavoriteLocationsViewModel {
    private var coreDataManager: CoreDataManager
    
    override func launch() {
        reloadLocations()
    }
    
    func reloadLocations() {
        let locationsEntity = self.coreDataManager.fetchLocations()
        var locations = [Location]()
        locationsEntity.forEach { locationEntity in
            locations.append(Location(locationEntity: locationEntity))
        }
        self.locations.value = (locations: locations, isFirstPage: true, isLastPage: true)
    }
    
    override init(coordinator: ILocationsRickAndMortyCoordinator) {
        self.coreDataManager = CoreDataManager.shared
        super.init(coordinator: coordinator)
    }
}
