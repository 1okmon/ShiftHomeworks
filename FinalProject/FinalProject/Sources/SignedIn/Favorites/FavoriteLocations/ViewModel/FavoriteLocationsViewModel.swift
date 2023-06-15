//
//  FavoriteLocationsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

final class FavoriteLocationsViewModel: LocationsViewModel, IFavoriteLocationsViewModel {
    private var coreDataManager: ILocationCoreDataManager
    
    override func launch() {
        self.reloadLocations()
    }
    
    func reloadLocations() {
        let locationsEntity = self.coreDataManager.fetchLocations()
        var locations = [Location]()
        locationsEntity.forEach { locationEntity in
            locations.append(Location(locationEntity: locationEntity))
        }
        self.locations.value = (locations: locations, page: Page(isFirst: true, isLast: true))
    }
    
    override init(coordinator: ILocationsRickAndMortyCoordinator) {
        self.coreDataManager = CoreDataManager.shared
        super.init(coordinator: coordinator)
    }
}
