//
//  CoreDataManager.swift
//  FinalProject
//
//  Created by 1okmon on 02.06.2023.
//

import UIKit
import CoreData

private enum EntityName {
    static let location = "LocationEntity"
    static let character = "CharacterEntity"
}

final class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    private let realtimeDatabaseManager: RealtimeDatabaseManager
    
    private override init() {
        self.realtimeDatabaseManager = RealtimeDatabaseManager.shared
    }
    
    func clean() {
        self.deleteAllLocations()
        self.deleteAllCharacters()
    }
    
    func loadUserData() {
        let characterLoadManager = RickAndMortyCharacterNetworkManager.shared
        let locationLoadManager = RickAndMortyLocationNetworkManager.shared
        self.realtimeDatabaseManager.loadUserData { userData in
            userData.favoriteCharacters?.forEach({ [weak self] id in
                characterLoadManager.loadCharacter(with: id) { [weak self] (character: CharacterDetails?, _) in
                    guard let character = character else { return }
                    characterLoadManager.loadImage(from: character.imageUrl) { image, _, _ in
                        DispatchQueue.main.async {
                            var characterCopy = character
                            characterCopy.image = image
                            self?.createCharacter(characterCopy)
                        }
                    }
                }
            })
            userData.favoriteLocations?.forEach({ [weak self] id in
                locationLoadManager.loadLocation(with: id) { location, _ in
                    guard let location = location else { return }
                    DispatchQueue.main.async {
                        self?.createLocation(location)
                    }
                }
            })
        }
    }
}

private extension CoreDataManager {
    var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate doesn't exist")
        }
        return appDelegate
    }
    
    var context: NSManagedObjectContext {
        self.appDelegate.persistentContainer.viewContext
    }
}

// MARK: LocationEntity extension
extension CoreDataManager: ILocationCoreDataManager {
    func createLocation(_ locationDetails: LocationDetails) {
        guard self.fetchLocation(with: locationDetails.id) == nil,
              let locationEntityDescription = NSEntityDescription
                    .entity(forEntityName: EntityName.location,
                            in: self.context) else { return }
        let location = LocationEntity(entity: locationEntityDescription, insertInto: self.context)
        location.id = Int32(locationDetails.id)
        location.name = locationDetails.name
        location.type = locationDetails.type
        location.dimension = locationDetails.dimension
        location.residents = try? JSONSerialization.data(withJSONObject: locationDetails.residents, options: [])
        self.appDelegate.saveContext()
        self.updateRealtimeDatabase(.locations)
    }
    
    func fetchLocations() -> [LocationEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            return (try? self.context.fetch(fetchRequest) as? [LocationEntity]) ?? []
        }
    }
    
    func fetchLocation(with id: Int) -> LocationEntity? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            let locations = try? self.context.fetch(fetchRequest) as? [LocationEntity]
            return locations?.first(where: { $0.id == id })
        }
    }
    
    func deleteAllLocations() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            let locations = try? self.context.fetch(fetchRequest) as? [LocationEntity]
            locations?.forEach({ [weak self] location in
                self?.context.delete(location)
            })
        }
        self.appDelegate.saveContext()
    }
    
    func deleteLocation(with id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            guard let locations = try? self.context.fetch(fetchRequest) as? [LocationEntity],
                  let location = locations.first(where: { $0.id == id }) else { return }
            self.context.delete(location)
        }
        self.appDelegate.saveContext()
        self.updateRealtimeDatabase(.locations)
    }
}

// MARK: CharacterEntity extension
extension CoreDataManager: ICharacterCoreDataManager {
    func createCharacter(_ characterDetails: CharacterDetails) {
        guard self.fetchCharacter(with: characterDetails.id) == nil,
              let characterEntityDescription = NSEntityDescription
                    .entity(forEntityName: EntityName.character,
                            in: self.context) else { return }
        
        let character = CharacterEntity(entity: characterEntityDescription, insertInto: self.context)
        character.id = Int32(characterDetails.id)
        character.name = characterDetails.name
        character.status = characterDetails.status
        character.species = characterDetails.species
        character.type = characterDetails.type
        character.gender = characterDetails.gender
        character.imageUrl = characterDetails.imageUrl
        character.image = characterDetails.image?.jpegData(compressionQuality: 1.0)
        self.appDelegate.saveContext()
        self.updateRealtimeDatabase(.characters)
    }
    
    func fetchCharacters() -> [CharacterEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            return (try? self.context.fetch(fetchRequest) as? [CharacterEntity]) ?? []
        }
    }
    
    func fetchCharacter(with id: Int) -> CharacterEntity? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            let characters = try? self.context.fetch(fetchRequest) as? [CharacterEntity]
            return characters?.first(where: { $0.id == id })
        }
    }
    
    func deleteAllCharacters() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            let characters = try? self.context.fetch(fetchRequest) as? [CharacterEntity]
            characters?.forEach({ [weak self] character in
                self?.context.delete(character)
            })
        }
        self.appDelegate.saveContext()
    }
    
    func deleteCharacter(with id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            guard let characters = try? self.context.fetch(fetchRequest) as? [CharacterEntity],
                  let character = characters.first(where: { $0.id == id }) else { return }
            self.context.delete(character)
        }
        self.appDelegate.saveContext()
        self.updateRealtimeDatabase(.characters)
    }
}

private extension CoreDataManager {
    enum UpdateType {
        case characters
        case locations
    }
    
    func updateRealtimeDatabase(_ type: UpdateType) {
        var entities: [IEntity]
        switch type {
        case .characters:
            entities = self.fetchCharacters()
        case .locations:
            entities = self.fetchLocations()
        }
        var favoriteIds = [Int]()
        entities.forEach { entity in
            favoriteIds.append(Int(entity.id))
        }
        switch type {
        case .characters:
            self.realtimeDatabaseManager.updateFavoriteCharacters(charactersIds: favoriteIds)
        case .locations:
            self.realtimeDatabaseManager.updateFavoriteLocations(locationsIds: favoriteIds)
        }
    }
}
