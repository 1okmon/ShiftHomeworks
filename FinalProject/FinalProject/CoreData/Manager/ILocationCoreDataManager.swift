//
//  ILocationCoreDataManager.swift
//  FinalProject
//
//  Created by 1okmon on 05.06.2023.
//

protocol ILocationCoreDataManager {
    func createLocation(_ locationDetails: LocationDetails)
    func fetchLocations() -> [LocationEntity]
    func fetchLocation(with id: Int) -> LocationEntity?
    func deleteLocation(with id: Int)
}
