//
//  CoreDataManager.swift
//  FinalProject
//
//  Created by 1okmon on 02.06.2023.
//

import UIKit
import CoreData

private enum EntityName {
    static let image = "ImageEntity"
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
    
    func create(_ image: UIImage, with id: UUID) {
        guard let imageEntityDescription = NSEntityDescription
            .entity(forEntityName: EntityName.image,
                    in: self.context) else { return }
        let existedImage = fetchImages().first { imageEntity in
            imageEntity.id == id
        }
        guard existedImage == nil else { return }
        let imageEntity = ImageEntity(entity: imageEntityDescription, insertInto: self.context)
        imageEntity.id = id
        imageEntity.imageData = image.jpegData(compressionQuality: 1.0)
        self.appDelegate.saveContext()
    }
    
    func fetchImages() -> [ImageEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.image)
        do {
            return (try? self.context.fetch(fetchRequest) as? [ImageEntity]) ?? []
        }
    }
    
    func fetchImage(with id: UUID) -> ImageEntity? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.image)
        do {
            let images = try? context.fetch(fetchRequest) as? [ImageEntity]
            return images?.first(where: { $0.id == id })
        }
    }
    
    func deleteAllImages() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.image)
        do {
            let images = try? context.fetch(fetchRequest) as? [ImageEntity]
            images?.forEach({ [weak self] image in
                self?.context.delete(image)
            })
        }
        self.appDelegate.saveContext()
    }
    
    func deleteImage(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.image)
        do {
            guard let images = try? context.fetch(fetchRequest) as? [ImageEntity],
                  let image = images.first(where: { $0.id == id }) else { return }
            self.context.delete(image)
        }
        self.appDelegate.saveContext()
    }
}
