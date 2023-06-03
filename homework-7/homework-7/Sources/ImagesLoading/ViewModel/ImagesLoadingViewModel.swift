//
//  ImagesLoadingPresenter.swift
//  homework7
//
//  Created by 1okmon on 28.05.2023.
//

import UIKit

final class ImagesLoadingViewModel: IImagesLoadingViewModel {
    private var imagesLoadingStates: Observable<[UUID: LoadingState]>
    private var isUrlRequestCreated: Observable<Bool>
    private var dataProvider = ImagesProvider.shared
    private var coreDataManager = CoreDataManager.shared
    
    init() {
        self.imagesLoadingStates = Observable<[UUID: LoadingState]>(value: [:])
        self.isUrlRequestCreated = Observable<Bool>(value: true)
        configureHandlers()
    }
    
    func subscribe(observer: IObserver) {
        self.imagesLoadingStates.subscribe(observer: observer)
        self.isUrlRequestCreated.subscribe(observer: observer)
    }
    
    func launch() {
        for imageEntity in self.coreDataManager.fetchImages() {
            guard let data = imageEntity.imageData,
                  let id = imageEntity.id,
                  let image = UIImage(data: data) else { continue }
            self.imagesLoadingStates.value.updateValue(.loaded(image: image), forKey: id)
        }
    }
    
    func load(from url: String, imageId: UUID) {
        guard let url = URL(string: url) else {
            self.isUrlRequestCreated.value = false
            return
        }
        self.imagesLoadingStates.value.updateValue(.loading(progress: 0), forKey: imageId)
        dataProvider.download(with: imageId, from: url)
    }
    
    func switchPause(with imageId: UUID) {
        guard let state = imagesLoadingStates.value[imageId] else { return }
        if case .paused(let progress) = state {
            self.imagesLoadingStates.value.updateValue(.loading(progress: progress), forKey: imageId)
        } else if case .loading(let progress) = state {
            self.imagesLoadingStates.value.updateValue(.paused(progress: progress), forKey: imageId)
        }
        dataProvider.switchPause(with: imageId)
    }
    
    func saveImage(with id: UUID) {
        guard case .loaded(let image) = imagesLoadingStates.value[id] else { return }
        self.coreDataManager.create(image, with: id)
    }
    
    func delete(with imageId: UUID) {
        imagesLoadingStates.value[imageId] = nil
        if .error != imagesLoadingStates.value[imageId] {
            self.coreDataManager.deleteImage(with: imageId)
        }
    }
}

private extension ImagesLoadingViewModel {
    func configureHandlers() {
        dataProvider.onProgress = { [weak self] progress, imageId in
            self?.imagesLoadingStates.value.updateValue(.loading(progress: progress), forKey: imageId)
        }
        dataProvider.completion = { [weak self] location, imageId in
            do {
                let data = try Data(contentsOf: location)
                guard let image = UIImage(data: data) else {
                    self?.imagesLoadingStates.value.updateValue(.error, forKey: imageId)
                    return
                }
                self?.imagesLoadingStates.value.updateValue(.loaded(image: image), forKey: imageId)
            } catch {
                self?.imagesLoadingStates.value.updateValue(.error, forKey: imageId)
            }
        }
    }
}
