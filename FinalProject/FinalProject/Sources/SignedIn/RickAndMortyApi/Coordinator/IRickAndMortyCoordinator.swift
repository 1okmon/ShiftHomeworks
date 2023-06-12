//
//  IRickAndMortyCoordinator.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import Foundation

protocol ILocationsRickAndMortyCoordinator {
    func openLocation(with id: Int)
}

protocol ILocationDetailsRickAndMortyCoordinator {
    func openCharacter(with id: Int)
    func goBack()
}

protocol ICharacterDetailsRickAndMortyCoordinator {
    func closePresentedController()
}
