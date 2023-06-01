//
//  LocationViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

final class LocationsViewModel {
    private var locations: Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>
    private var coordinator: RickAndMortyCoordinator
    init(coordinator: RickAndMortyCoordinator) {
        self.locations = Observable<(locations: [Location], isFirstPage: Bool, isLastPage: Bool)>()
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager()
        self.coordinator = coordinator
    }
    
    func suscribe(observer: IObserver) {
        self.locations.subscribe(observer: observer)
    }
}
