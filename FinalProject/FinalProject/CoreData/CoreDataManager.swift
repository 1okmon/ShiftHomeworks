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
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate doesn't exist")
        }
        return appDelegate
    }
    
    private var context: NSManagedObjectContext {
        self.appDelegate.persistentContainer.viewContext
    }
}

// MARK: LocationEntity extension
extension CoreDataManager: ILocationCoreDataManager {
    func createLocation(_ locationDetails: LocationDetails) {
        guard let locationEntityDescription = NSEntityDescription
            .entity(forEntityName: EntityName.location,
                    in: self.context) else { return }
        
        let location = LocationEntity(entity: locationEntityDescription, insertInto: self.context)
        location.id = Int32(locationDetails.id)
        location.name = locationDetails.name
        location.type = locationDetails.type
        location.dimension = locationDetails.dimension
        location.residents = try? JSONSerialization.data(withJSONObject: locationDetails.residents, options: [])
        self.appDelegate.saveContext()
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
            let locations = try? context.fetch(fetchRequest) as? [LocationEntity]
            return locations?.first(where: { $0.id == id })
        }
    }
    
    func deleteAllLocations() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            let locations = try? context.fetch(fetchRequest) as? [LocationEntity]
            locations?.forEach({ [weak self] location in
                self?.context.delete(location)
            })
        }
        self.appDelegate.saveContext()
    }
    
    func deleteLocation(with id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.location)
        do {
            guard let locations = try? context.fetch(fetchRequest) as? [LocationEntity],
                  let location = locations.first(where: { $0.id == id }) else { return }
            self.context.delete(location)
        }
        self.appDelegate.saveContext()
    }
}

// MARK: CharacterEntity extension
extension CoreDataManager: ICharacterCoreDataManager {
    func createCharacter(_ characterDetails: CharacterDetails) {
        guard let characterEntityDescription = NSEntityDescription
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
            let characters = try? context.fetch(fetchRequest) as? [CharacterEntity]
            return characters?.first(where: { $0.id == id })
        }
    }
    
    func deleteAllCharacters() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            let characters = try? context.fetch(fetchRequest) as? [CharacterEntity]
            characters?.forEach({ [weak self] character in
                self?.context.delete(character)
            })
        }
        self.appDelegate.saveContext()
    }
    
    func deleteCharacter(with id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.character)
        do {
            guard let characters = try? context.fetch(fetchRequest) as? [CharacterEntity],
                  let character = characters.first(where: { $0.id == id }) else { return }
            self.context.delete(character)
        }
        self.appDelegate.saveContext()
    }
}
