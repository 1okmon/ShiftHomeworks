//
//  ImageEntity+CoreDataProperties.swift
//  
//
//  Created by 1okmon on 02.06.2023.
//
//

import Foundation
import CoreData

@objc(ImageEntity)
public class ImageEntity: NSManagedObject {}

extension ImageEntity {
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
}

extension ImageEntity: Identifiable {}
