//
//  LocationViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

class LocationsViewModel: ILocationsViewModel {
    var locations: Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>
    private var previousPage: String?
    private var nextPage: String?
    private var coordinator: ILocationsRickAndMortyCoordinator
    private let locationsNetworkManager: RickAndMortyLocationNetworkManager
    
    init(coordinator: ILocationsRickAndMortyCoordinator) {
        self.locations = Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>()
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager.shared
        self.coordinator = coordinator
    }
    
    func subscribe(observer: IObserver) {
        self.locations.subscribe(observer: observer)
        launch()
    }
    
    func launch() {
        loadLocations()
    }
    
    func loadNextPage() {
        loadLocations(from: nextPage)
    }
    
    func loadPreviousPage() {
        loadLocations(from: previousPage)
    }
    
    func openLocation(with id: Int) {
        self.coordinator.openLocation(with: id)
    }
}

private extension LocationsViewModel {
    private func loadLocations(from link: String? = nil) {
        self.locationsNetworkManager.loadLocations(from: link) { [weak self] locations, previousPage, nextPage in
            self?.locations.value = (locations, previousPage == nil, nextPage == nil)
            self?.previousPage = previousPage
            self?.nextPage = nextPage
        }
    }
}
