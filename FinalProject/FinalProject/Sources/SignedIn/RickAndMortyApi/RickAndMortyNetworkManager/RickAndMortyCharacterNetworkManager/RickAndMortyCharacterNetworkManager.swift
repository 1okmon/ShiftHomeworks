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

final class RickAndMortyCharacterNetworkManager: NSObject {
    static let shared: RickAndMortyCharacterNetworkManager = RickAndMortyCharacterNetworkManager()
    var completion: ((URL, String) -> Void)?
    private var session: URLSession?
    private var downloadTasks: [String: URLSessionDownloadTask]
    
    private override init() {
        self.downloadTasks = [String: URLSessionDownloadTask]()
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: Metrics.sessionIdentifier)
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard let session = session else { return }
        let task = session.downloadTask(with: url)
        task.resume()
        downloadTasks.updateValue(task, forKey: urlString)
    }
    
    func loadCharacter<T: ICharacter>(with id: Int, completion: ((T) -> Void)?) {
        let urlString = Metrics.charactersLink + "\(id)"
        self.loadCharacter(by: urlString, completion: completion)
    }
    
    func loadCharacter<T: ICharacter>(by urlString: String, completion: ((T) -> Void)?) {
        let task = dataTask(by: urlString) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result: CharacterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                let character = T(characterResponse: result)
                completion?(character)
            } catch {
                print(1)
            }
        }
        task.resume()
    }
}

private extension RickAndMortyCharacterNetworkManager {
    func dataTask(by urlString: String, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask {
        guard let url = URL(string: urlString) else {
            fatalError("invalid rickAndMorty Location id")
        }
        var request = URLRequest(url: url)
                request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        return session.dataTask(with: request, completionHandler: completionHandler)
    }
}

extension RickAndMortyCharacterNetworkManager: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let urlString = downloadTasks.first(where: { $1 == downloadTask })?.key else { return }
        completion?(location, urlString)
    }
}
