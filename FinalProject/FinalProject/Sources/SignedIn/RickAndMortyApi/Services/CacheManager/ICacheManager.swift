//
//  ICacheManager.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit

protocol ICacheManager {
    func append(image: UIImage, with key: String)
    func image(by key: String) -> UIImage?
}
