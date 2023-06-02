//
//  LocationDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class LocationDetailsViewModel {
    private var coordinator: RickAndMortyCoordinator?
    private let locationsNetworkManager: RickAndMortyLocationNetworkManager
    private let charactersNetworkManager: RickAndMortyCharacterNetworkManager
    private let coreDataManager: CoreDataManager
    private var locationDetails: Observable<LocationDetails>
    private var residents: Observable<[Character]>
    private var isFavorite: Observable<Bool>
    private var residentsImages: Observable<[String: UIImage?]>
    
    init(coordinator: RickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager()
        self.charactersNetworkManager = RickAndMortyCharacterNetworkManager.shared
        self.coreDataManager = CoreDataManager.shared
        self.locationDetails = Observable<LocationDetails>()
        self.residents = Observable<[Character]>([])
        self.isFavorite = Observable<Bool>(false)
        self.residentsImages = Observable<[String: UIImage?]>([:])
    }
    
    func subscribe(observer: IObserver) {
        self.locationDetails.subscribe(observer: observer)
        self.residents.subscribe(observer: observer)
        self.residentsImages.subscribe(observer: observer)
        self.isFavorite.subscribe(observer: observer)
    }
    
    func loadLocation(with id: Int) {
        self.locationsNetworkManager.loadLocation(with: id) { [weak self] location in
            DispatchQueue.main.async {
                self?.isFavorite.value = self?.coreDataManager.fetchLocation(with: id) != nil
            }
            self?.locationDetails.value = location
        }
    }
    
    func loadCharacters() {
        self.locationDetails.value?.residents.forEach { [weak self] residentUrl in
            self?.loadCharacter(by: residentUrl)
        }
    }
    
    func switchAddedInFavourites() {
        guard let locationDetails = self.locationDetails.value,
              let isFavorite = self.isFavorite.value else { return }
        if isFavorite {
            self.coreDataManager.deleteLocation(with: locationDetails.id)
        } else {
            self.coreDataManager.createLocation(locationDetails)
        }
        self.isFavorite.value = !isFavorite
    }
    
    func openCharacter(with id: Int) {
        self.coordinator?.openCharacter(with: id)
    }
}

private extension LocationDetailsViewModel {
    func loadCharacter(by url: String) {
        self.charactersNetworkManager.loadCharacter(by: url) { [weak self] (character: Character) in
            DispatchQueue.main.async {
                self?.residents.value?.append(character)
            }
            self?.loadImage(by: character.image)
        }
    }
    
    func loadImage(by url: String) {
        self.charactersNetworkManager.loadImage(from: url) { [weak self] image, urlString in
            DispatchQueue.main.async {
                self?.residentsImages.value?.updateValue(image, forKey: urlString)
            }
        }
    }
}
