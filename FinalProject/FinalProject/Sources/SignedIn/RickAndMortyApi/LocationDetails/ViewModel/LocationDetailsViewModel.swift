//
//  LocationDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class LocationDetailsViewModel {
    private var coordinator: RickAndMortyCoordinator?
    private var locationDetails: Observable<LocationDetails>
    private var residents: Observable<[Character]>
    private var residentsImages: Observable<[String: UIImage?]>
    
    init(coordinator: RickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager()
        self.charactersNetworkManager = RickAndMortyCharacterNetworkManager.shared
        self.locationDetails = Observable<LocationDetails>()
        self.residents = Observable<[Character]>([])
        self.residentsImages = Observable<[String: UIImage?]>([:])
    }
    
    func subscribe(observer: IObserver) {
        self.locationDetails.subscribe(observer: observer)
        self.residents.subscribe(observer: observer)
        self.residentsImages.subscribe(observer: observer)
    }
}
