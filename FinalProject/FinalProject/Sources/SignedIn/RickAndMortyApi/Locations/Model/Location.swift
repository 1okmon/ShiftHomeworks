//
//  Location.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import Foundation

struct Location {
    let id: Int
    let name: String
    let residentsCount: Int
    
    init(locationResponse: LocationResponse) {
        self.id = locationResponse.id
        self.name = locationResponse.name
        self.residentsCount = locationResponse.residents.count
    }
}
