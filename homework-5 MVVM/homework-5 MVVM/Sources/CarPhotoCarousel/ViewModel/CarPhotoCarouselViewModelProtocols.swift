//
//  CarPhotoCarouselViewModelProtocol.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

typealias ICarPhotoCarouselViewModel = ICarPhotoCarouselViewModelData & ICarPhotoCarouselViewModelCoordinator

protocol ICarPhotoCarouselViewModelData {
    var images: [UIImage?]? { get }
}

protocol ICarPhotoCarouselViewModelCoordinator {
    func dismiss()
}
