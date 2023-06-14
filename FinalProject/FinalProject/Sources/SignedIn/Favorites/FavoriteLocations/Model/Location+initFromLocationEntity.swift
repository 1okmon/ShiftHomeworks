//
//  Location+initFromLocationEntity.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

import Foundation

extension Location {
    init(locationEntity: LocationEntity) {
        self.id = Int(locationEntity.id)
        self.name = locationEntity.name
        if let residentsData = locationEntity.residents,
           let residents = try? JSONSerialization.jsonObject(with: residentsData, options: []) as? [String] {
            self.residentsCount = residents.count
        } else {
            self.residentsCount = 0
        }
    }
}
