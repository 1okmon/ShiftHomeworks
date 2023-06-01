//
//  CharacterDetailsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class CharacterDetailsViewModel {
    private var coordinator: RickAndMortyCoordinator?
    private let charactersNetworkManager: RickAndMortyCharacterNetworkManager
    private var character: Observable<CharacterDetails>
    
    init(coordinator: RickAndMortyCoordinator) {
        self.coordinator = coordinator
        self.charactersNetworkManager = RickAndMortyCharacterNetworkManager.shared
        self.character = Observable<CharacterDetails>()
    }
    
    func subscribe(observer: IObserver) {
        self.character.subscribe(observer: observer)
    }
    
    func loadCharacter(with id: Int) {
        self.charactersNetworkManager.loadCharacter(with: id) { [weak self] (character: CharacterDetails) in
            DispatchQueue.main.async {
                self?.character.value = character
            }
            self?.loadImage(by: character.imageUrl)
        }
    }
    
    func loadImage(by url: String) {
        self.charactersNetworkManager.completion = { [weak self] location, _ in
            do {
                let data = try Data(contentsOf: location)
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.character.value?.image = image
                }
            } catch {
                print(2)
            }
        }
        self.charactersNetworkManager.loadImage(from: url)
    }
}
