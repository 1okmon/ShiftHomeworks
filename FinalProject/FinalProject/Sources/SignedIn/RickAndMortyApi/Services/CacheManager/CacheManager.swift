//
//  ImageManager.swift
//  FinalProject
//
//  Created by 1okmon on 01.06.2023.
//

import UIKit

private enum Metrics {
    static let maxImagesCountInCache = 300
    static let countOfImagesToCleanIfNeeded = 20
}

final class CacheManager: ICacheManager {
    private let queue = DispatchQueue(label: "CacheManagerQueue", attributes: .concurrent)
    private var imageDictionary: [String: UIImage]
    
    init() {
        self.imageDictionary = [:]
    }
    
    func append(image: UIImage, with key: String) {
        self.queue.async(flags: .barrier) {
            self.cleanImageDictionaryIfNeeded()
            self.imageDictionary.updateValue(image, forKey: key)
        }
    }
    
    func image(by key: String) -> UIImage? {
        self.queue.sync {
            return self.imageDictionary[key]
        }
    }
}

private extension CacheManager {
    func cleanImageDictionaryIfNeeded() {
        let allKeys = self.imageDictionary.keys
        guard allKeys.count > Metrics.maxImagesCountInCache else {
            return
        }
        let firstKeys = allKeys.prefix(allKeys.count - Metrics.countOfImagesToCleanIfNeeded)
        for key in firstKeys {
            self.imageDictionary.removeValue(forKey: key)
        }
    }
}
