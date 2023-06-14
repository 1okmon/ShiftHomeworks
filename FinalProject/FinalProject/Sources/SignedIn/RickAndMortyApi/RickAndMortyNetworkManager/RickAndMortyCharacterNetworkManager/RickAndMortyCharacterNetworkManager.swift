//
//  RickAndMortyCharacterNetworkManager.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let sessionIdentifier = "ImagesLoadingSession"
    static let charactersLink = "https://rickandmortyapi.com/api/character/"
}

final class RickAndMortyCharacterNetworkManager: NSObject, ICharacterNetworkManagerCharacterDetails, ICharacterNetworkManagerLocationsDetails {
    static let shared: RickAndMortyCharacterNetworkManager = RickAndMortyCharacterNetworkManager()
    private var imagesManager: ICacheManager
    private let dataTasksQueue = DispatchQueue(label: "updateDownloadTasksQueue", qos: .userInitiated, attributes: .concurrent)
    let queue = DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)
    
    private override init() {
        self.imagesManager = CacheManager()
        super.init()
    }
    
    func loadImage(from urlString: String, completion: ((UIImage?, String?, IAlertRepresentable?) -> Void)?) {
        self.dataTasksQueue.async {
            if let image = self.imagesManager.image(by: urlString) {
                completion?(image, urlString, nil)
            } else {
                let task = self.dataTask(by: urlString) { [weak self] data, _, error in
                    if let error = error {
                        let errorCode = NetworkResponseCodeParser().parse(error: error)
                        completion?(nil, nil, errorCode)
                    }
                    guard let data = data, error == nil else { return }
                    guard let image = UIImage(data: data) else { return }
                    self?.imagesManager.append(image: image, with: urlString)
                    completion?(image, urlString, nil)
                }
                task.resume()
            }
        }
    }
    
    func loadCharacter<T: ICharacter>(with id: Int, completion: ((T?, IAlertRepresentable?) -> Void)?) {
        let urlString = Metrics.charactersLink + "\(id)"
        self.loadCharacter(by: urlString, completion: completion)
    }
    
    func loadCharacter<T: ICharacter>(by urlString: String, completion: ((T?, IAlertRepresentable?) -> Void)?) {
        let task = dataTask(by: urlString) { data, _, error in
            if let error = error {
                let errorCode = NetworkResponseCodeParser().parse(error: error)
                completion?(nil, errorCode)
            }
            guard let data = data, error == nil else { return }
            do {
                let result: CharacterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                let character = T(characterResponse: result)
                completion?(character, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

private extension RickAndMortyCharacterNetworkManager {
    func dataTask(by urlString: String, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask {
        let session = URLSession(configuration: .default)
        return session.dataTask(with: self.request(with: urlString),
                                completionHandler: completionHandler)
    }
    
    func request(with url: String, method: String = "GET") -> URLRequest {
        guard let url = URL(string: url) else {
            fatalError("invalid rickAndMorty url: \(url)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
