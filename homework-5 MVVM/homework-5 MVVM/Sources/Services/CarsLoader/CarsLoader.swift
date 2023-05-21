//
//  CarsLoader.swift
//  homework-5 MVVM
//
//  Created by 1okmon on 20.05.2023.
//

import UIKit

private enum Metrics {
    static let carsFileName = "Cars"
    static let carsFileExtension = "json"
}

final class CarsLoader {
    static let shared = CarsLoader()
    
    private init() {}
    
    func cars() -> [CarModel] {
        guard let carsJson = self.loadCarsFromJson() else { return [] }
        var carModels = [CarModel]()
        carsJson.forEach { carJson in
            carModels.append(self.carModel(from: carJson))
        }
        return carModels
    }
    
    func car(with id: Int) -> CarModel? {
        guard let carJson = self.loadCarFromJson(with: id) else { return nil }
        return carModel(from: carJson)
    }
}

private extension CarsLoader {
    func loadCarsFromJson() -> [CarModelJson]? {
        guard let fileUrl = Bundle.main.url(forResource: Metrics.carsFileName,
                                            withExtension: Metrics.carsFileExtension) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let jsonData = try JSONDecoder().decode(CarsModelJson.self, from: data)
            return jsonData.cars
        } catch {
            print("error:\(error)")
        }
        return nil
    }
    
    func loadCarFromJson(with id: Int) -> CarModelJson? {
        guard let cars = self.loadCarsFromJson() else { return nil }
        return cars.first { $0.id == id }
    }
    
    func loadCarsImages(_ imageNames: [String]?) -> [UIImage?]? {
        var images = [UIImage?]()
        imageNames?.forEach {
            images.append(UIImage(named: $0))
        }
        return images
    }
    
    func carModel(from carJson: CarModelJson) -> CarModel {
        CarModel(id: carJson.id,
                 manufacturer: carJson.manufacturer,
                 model: carJson.model,
                 images: self.loadCarsImages(carJson.images),
                 yearOfIssue: carJson.yearOfIssue)
    }
}
