//
//  LocationViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

typealias Page = (isFirst: Bool, isLast: Bool)

class LocationsViewModel: ILocationsViewModel {
    var locations: Observable<(locations: [Location], page: Page)>
    var errorCode: Observable<IAlertRepresentable>
    private var previousPage: String?
    private var nextPage: String?
    private var reloadPage: String?
    private var coordinator: ILocationsRickAndMortyCoordinator
    private let locationsNetworkManager: ILocationNetworkManagerLocations
    
    init(coordinator: ILocationsRickAndMortyCoordinator) {
        self.locations = Observable<(locations: [Location], page: Page)>()
        self.errorCode = Observable<IAlertRepresentable>()
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager.shared
        self.coordinator = coordinator
    }
    
    func subscribe(observer: IObserver) {
        self.locations.subscribe(observer: observer)
        self.errorCode.subscribe(observer: observer)
        self.launch()
    }
    
    func launch() {
        self.loadLocations()
    }
    
    func reload() {
        self.loadLocations(from: self.reloadPage)
    }
    
    func loadNextPage() {
        self.loadLocations(from: self.nextPage)
    }
    
    func loadPreviousPage() {
        self.loadLocations(from: self.previousPage)
    }
    
    func openLocation(with id: Int) {
        self.coordinator.openLocation(with: id)
    }
}

private extension LocationsViewModel {
    private func loadLocations(from link: String? = nil) {
        self.reloadPage = link
        self.locationsNetworkManager.loadLocations(from: link) { [weak self] locations, previousPage, nextPage, responseErrorCode in
            guard responseErrorCode == nil else {
                self?.errorCode.value = responseErrorCode
                return
            }
            self?.locations.value = (locations, Page(isFirst: previousPage == nil, isLast: nextPage == nil))
            self?.previousPage = previousPage
            self?.nextPage = nextPage
        }
    }
}
