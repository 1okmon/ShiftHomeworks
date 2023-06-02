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
    var completions: [String: [((UIImage, String) -> Void)?]]
    //private var session: URLSession?
    //private var downloadTasks: [String: URLSessionDownloadTask]
    private var imagesManager: CacheManager
    //private let appendCompletionSemaphore = DispatchSemaphore(value: 0)
    private let updateDownloadTasksQueue = DispatchQueue(label: "updateDownloadTasksQueue", qos: .userInitiated, attributes: .concurrent)
    //private let downloadTasksQueue = DispatchQueue(label: "addTaskQueue", qos: .utility)
    let queue = DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)
    
    private override init() {
        self.imagesManager = CacheManager()
        self.completions = [:]
        //self.downloadTasks = [String: URLSessionDownloadTask]()
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: Metrics.sessionIdentifier)
        //self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    //    func loadImage(from urlString: String, completion: ((UIImage, String) -> Void)?) {
    //        self.updateDownloadTasksQueue.async {
    //            self.append(completion, for: urlString)
    //            self.appendCompletionSemaphore.wait()
    //            if let image = self.imagesManager.image(by: urlString) {
    //                DispatchQueue.main.async {
    //                    self.startCompletionsForLoadedImage(from: urlString, with: image)
    //                    return
    //                }
    //            } else {
    //                guard self.downloadTasks[urlString] == nil else { return }
    //                guard let session = self.session else { return }
    //                let task = session.downloadTask(with: self.request(with: urlString))
    //                task.resume()
    //                self.queue.async(flags: .barrier) {
    //                    self.downloadTasks.updateValue(task, forKey: urlString)
    //                }
    //
    //            }
    //        }
    //    }
    
    func loadImage(from urlString: String, completion: ((UIImage, String) -> Void)?) {
        self.updateDownloadTasksQueue.async {
            if let image = self.imagesManager.image(by: urlString) {
                completion?(image, urlString)
            } else {
                let task = self.dataTask(by: urlString) { data, _, error in
                    guard let data = data, error == nil else { return }
                    guard let image = UIImage(data: data) else { return }
                    self.imagesManager.append(image: image, with: urlString)
                    completion?(image, urlString)
                }
                task.resume()
            }
        }
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
        let session = URLSession(configuration: .default)
        return session.dataTask(with: request(with: urlString),
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
    
//    func append(_ completion: ((UIImage, String) -> Void)?, for urlString: String) {
//        DispatchQueue.main.async {
//            
//            if self.completions[urlString] == nil {
//                self.completions[urlString] = []
//            }
//            self.completions[urlString]?.append(completion)
//            print(39)
//            //self.appendCompletionSemaphore.signal()
//        }
//    }
    
//    func startCompletionsForLoadedImage(from urlString: String, with image: UIImage) {
//        self.completions[urlString]?.forEach({ completion in
//            completion?(image, urlString)
//        })
//        self.completions.removeValue(forKey: urlString)
//        //        queue.async(flags: .barrier) {
//        //            self.downloadTasks.removeValue(forKey: urlString)
//        //        }
//
//    }
    
//    func imageLoaded(at location: URL, from urlString: String) {
//        do {
//            let data = try Data(contentsOf: location)
//            guard let image = UIImage(data: data) else { return }
//            self.imagesManager.append(image: image, with: urlString)
//            DispatchQueue.main.async {
//                self.startCompletionsForLoadedImage(from: urlString, with: image)
//            }
//        } catch {
//            print(error)
//            print(2)
//        }
//    }
}

//extension RickAndMortyCharacterNetworkManager: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        guard let urlString = self.downloadTasks.filter({ $0.value == downloadTask }).keys.first else { return }
//        imageLoaded(at: location, from: urlString)
//    }
//}
