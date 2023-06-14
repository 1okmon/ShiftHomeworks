//
//  LocationEntity+CoreDataProperties.swift
//  
//
//  Created by 1okmon on 02.06.2023.
//
//

import Foundation
import CoreData

@objc(LocationEntity)
public class LocationEntity: NSManagedObject {}

extension LocationEntity: IEntity {
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var dimension: String
    @NSManaged public var residents: Data?
}

extension LocationEntity: Identifiable {}
