//
//  LocationsResponse.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import Foundation

struct LocationsResponse: Decodable {
    let info: LocationsResponseInfo
    let results: [LocationResponse]
}
