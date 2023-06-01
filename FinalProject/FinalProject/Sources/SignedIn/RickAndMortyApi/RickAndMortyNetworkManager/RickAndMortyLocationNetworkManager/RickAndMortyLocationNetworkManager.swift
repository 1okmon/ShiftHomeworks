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

final class RickAndMortyLocationNetworkManager {
    func loadLocations(from link: String?, completion: (([Location], String?, String?) -> Void)?) {
        let url: String = link ?? URLS.locationsLink
        let task = dataTask(by: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result: LocationsResponse = try JSONDecoder().decode(LocationsResponse.self, from: data)
                var locations: [Location] = []
                result.results.forEach { location in
                    locations.append(Location(locationResponse: location))
                }
                completion?(locations, result.info.prev, result.info.next)
            } catch {
                print(1)
            }
        }
        task.resume()
    }
    
    func loadLocation(with id: Int, completion: ((LocationDetails) -> Void)?) {
        let url = URLS.locationsLink + "\(id)"
        let task = dataTask(by: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result: LocationResponse = try JSONDecoder().decode(LocationResponse.self, from: data)
                let locationDetailed = LocationDetails(locationResponse: result)
                completion?(locationDetailed)
            } catch {
                print(1)
            }
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