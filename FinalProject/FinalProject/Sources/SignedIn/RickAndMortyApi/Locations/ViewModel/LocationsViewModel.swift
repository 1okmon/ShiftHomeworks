//
//  LocationViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

final class LocationsViewModel {
    private var previousPage: String?
    private var nextPage: String?
    private var locations: Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>
    private var coordinator: RickAndMortyCoordinator
    private let locationsNetworkManager: RickAndMortyLocationNetworkManager
    
    init(coordinator: RickAndMortyCoordinator) {
        self.locations = Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>()
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager()
        self.coordinator = coordinator
    }
    
    func suscribe(observer: IObserver) {
        self.locations.subscribe(observer: observer)
    }
    
    func loadNextPage() {
        loadLocations(from: nextPage)
    }
    
    func loadPreviousPage() {
        loadLocations(from: previousPage)
    }
    
    func openLocation(with id: Int) {
        self.coordinator.openLocations(with: id)
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
