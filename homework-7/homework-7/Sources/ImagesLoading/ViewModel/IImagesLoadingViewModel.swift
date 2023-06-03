//
//  IImagesLoadingViewModel.swift
//  homework7
//
//  Created by 1okmon on 29.05.2023.
//

import Foundation

protocol IImagesLoadingViewModel {
    func launch()
    func load(from url: String, imageId: UUID)
    func switchPause(with imageId: UUID)
    func delete(with imageId: UUID)
    func saveImage(with id: UUID)
}
