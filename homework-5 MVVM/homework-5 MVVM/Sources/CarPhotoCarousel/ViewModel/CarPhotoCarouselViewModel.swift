//
//  CarPhotoCarouselViewModel.swift
//  CollectionApp
//
//  Created by 1okmon on 12.05.2023.
//

import UIKit

final class CarPhotoCarouselViewModel {
    weak var coordinator : AppCoordinator?
    private var carPhotoCarouselModel: CarPhotoCarouselModel
    
    init(car: Car) {
        self.carPhotoCarouselModel = CarPhotoCarouselModel(images:  car.carModel.images)
    }
}

extension CarPhotoCarouselViewModel: ICarPhotoCarouselViewModelData {
    var images: [UIImage?]? {
        self.carPhotoCarouselModel.images
    }
}

extension CarPhotoCarouselViewModel: ICarPhotoCarouselViewModelCoordinator {
    func dismiss() {
        self.coordinator?.dismiss()
    }
}
