//
//  LocationDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class LocationDetailsViewModel: ILocationDetailsViewModel {
    private var coordinator: ILocationDetailsRickAndMortyCoordinator?
    private let locationsNetworkManager: RickAndMortyLocationNetworkManager
    private let charactersNetworkManager: RickAndMortyCharacterNetworkManager
    private let coreDataManager: ILocationCoreDataManager
    private var locationDetails: Observable<LocationDetails>
    private var errorCode: Observable<IAlertRepresentable>
    private var residents: Observable<[Character]>
    private var isFavorite: Observable<Bool>
    private var residentsImages: Observable<[String: UIImage?]>
    
    init(coordinator: ILocationDetailsRickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.errorCode = Observable<IAlertRepresentable>()
        self.locationsNetworkManager = RickAndMortyLocationNetworkManager.shared
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
        self.errorCode.subscribe(observer: observer)
    }
    
    func loadLocation(with id: Int) {
        self.locationsNetworkManager.loadLocation(with: id) { [weak self] location, responseErrorCode in
            guard responseErrorCode == nil else {
                self?.errorCode.value = responseErrorCode
                return
            }
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
    
    func goBack() {
        self.coordinator?.goBack()
    }
}

private extension LocationDetailsViewModel {
    func loadCharacter(by url: String) {
        self.charactersNetworkManager.loadCharacter(by: url) { [weak self] (character: Character?, responseErrorCode) in
            guard let character = character, responseErrorCode == nil else {
                self?.errorCode.value = responseErrorCode
                return
            }
            DispatchQueue.main.async {
                self?.residents.value?.append(character)
            }
            self?.loadImage(by: character.image)
        }
    }
    
    func loadImage(by url: String) {
        self.charactersNetworkManager.loadImage(from: url) { [weak self] image, urlString, responseErrorCode in
            guard let image = image,
                  let urlString = urlString,
                  responseErrorCode == nil else {
                self?.errorCode.value = responseErrorCode
                return
            }
            DispatchQueue.main.async {
                self?.residentsImages.value?.updateValue(image, forKey: urlString)
            }
        }
    }
}
