//
//  IRickAndMortyLocationNetworkManager.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import Foundation

protocol ILocationNetworkManagerLocations {
    func loadLocations(from link: String?, completion: (([Location], String?, String?, IAlertRepresentable?) -> Void)?)
}

protocol ILocationNetworkManagerLocationDetails {
    func loadLocation(with id: Int, completion: ((LocationDetails?, IAlertRepresentable?) -> Void)?)
}
