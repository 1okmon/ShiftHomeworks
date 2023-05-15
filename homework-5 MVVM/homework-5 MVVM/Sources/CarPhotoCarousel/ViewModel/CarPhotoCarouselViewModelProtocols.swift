//
//  CarPhotoCarouselViewModelProtocol.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

protocol ICarPhotoCarouselViewModelData {
    var images: [UIImage?]? { get }
}

protocol ICarPhotoCarouselViewModelCoordinator {
    func dismiss()
}

typealias ICarPhotoCarouselViewModel = ICarPhotoCarouselViewModelData & ICarPhotoCarouselViewModelCoordinator
