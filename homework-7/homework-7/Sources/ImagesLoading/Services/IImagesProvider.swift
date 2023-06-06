//
//  IImagesProvider.swift
//  homework7
//
//  Created by 1okmon on 29.05.2023.
//

import Foundation
protocol IImagesProvider {
    static var shared: IImagesProvider { get }
    var onProgress: ((Float, UUID) -> Void)? { get set }
    var completion: ((URL, UUID) -> Void)? { get set }
    func download(with imageId: UUID, from url: URL)
    func switchPause(with imageId: UUID)
}
