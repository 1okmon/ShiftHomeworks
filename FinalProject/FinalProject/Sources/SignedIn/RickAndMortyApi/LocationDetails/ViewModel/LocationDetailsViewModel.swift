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
    
    func loadLocation(with id: Int) {
        self.locationsNetworkManager.loadLocation(with: id) { [weak self] location in
            self?.locationDetails.value = location
            location.residents.forEach { [weak self] residentUrl in
                self?.loadCharacter(by: residentUrl)
            }
        }
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
            self?.residentsImages.value?.updateValue(image, forKey: urlString)
        }
    }
}
