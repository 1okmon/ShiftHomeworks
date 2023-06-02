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
    static let character = "Character"
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
    
    func createLocation(_ locationDetails: LocationDetails) {
        guard let locationEntityDescription = NSEntityDescription
            .entity(forEntityName: EntityName.location,
                    in: self.context) else { return }
        
        let location = LocationEntity(entity: locationEntityDescription, insertInto: self.context)
        location.id = Int32(locationDetails.id)
        location.name = locationDetails.name
        location.type = locationDetails.type
        location.dimension = locationDetails.dimension
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
