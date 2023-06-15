//
//  LocationDetails.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

struct LocationDetails {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    
    init(locationResponse: LocationResponse) {
        self.id = locationResponse.id
        self.name = locationResponse.name
        self.type = locationResponse.type
        self.dimension = locationResponse.dimension
        self.residents = locationResponse.residents
    }
}
