//
//  LocationResponse.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

struct LocationResponse: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}
