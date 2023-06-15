//
//  RickAndMortyLocationNetworkManager.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import Foundation
private enum URLS {
    static let locationsLink = "https://rickandmortyapi.com/api/location/"
}

final class RickAndMortyLocationNetworkManager: ILocationNetworkManagerLocations, ILocationNetworkManagerLocationDetails {
    static let shared = RickAndMortyLocationNetworkManager()
    private init() {}
    
    func loadLocations(from link: String?, completion: (([Location], String?, String?, IAlertRepresentable?) -> Void)?) {
        let url: String = link ?? URLS.locationsLink
        let task = dataTask(by: url) { data, _, error in
            if let error = error {
                let errorCode = NetworkResponseCodeParser().parse(error: error)
                completion?([], nil, nil, errorCode)
            }
            guard let data = data,
                  error == nil,
                  let result: LocationsResponse = try? JSONDecoder().decode(LocationsResponse.self, from: data) else { return }
            var locations: [Location] = []
            result.results.forEach { location in
                locations.append(Location(locationResponse: location))
            }
            completion?(locations, result.info.prev, result.info.next, nil)
        }
        task.resume()
    }
    
    func loadLocation(with id: Int, completion: ((LocationDetails?, IAlertRepresentable?) -> Void)?) {
        let url = URLS.locationsLink + "\(id)"
        let task = dataTask(by: url) { data, _, error in
            if let error = error {
                let errorCode = NetworkResponseCodeParser().parse(error: error)
                completion?(nil, errorCode)
            }
            guard let data = data,
                  error == nil,
                  let result: LocationResponse = try? JSONDecoder().decode(LocationResponse.self, from: data) else { return }
            let locationDetailed = LocationDetails(locationResponse: result)
            completion?(locationDetailed, nil)
        }
        task.resume()
    }
}
private extension RickAndMortyLocationNetworkManager {
    func dataTask(by url: String, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTask {
        guard let url = URL(string: url) else {
            fatalError("invalid rickAndMorty Location id")
        }
        var request = URLRequest(url: url)
                request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        return session.dataTask(with: request, completionHandler: completionHandler)
    }
}
