//
//  CarPhotoCarouselViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

fileprivate enum NavigationControllerMetrics {
   static let leftBarButtonItemTitle = "Close"
}

final class CarPhotoCarouselViewController: UIViewController {
    var model: CarPhotosForCarouselModel?
    private var updateLayout: (()->()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: NavigationControllerMetrics.leftBarButtonItemTitle,
            style: .done,
            target: self,
            action: #selector(dismissPhotoCarousel))
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

extension CarPhotoCarouselViewController {
    @objc func dismissPhotoCarousel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure() {
        guard let model = model else { return }
        let carPhotoCarouselView = CarPhotoCarouselView(model: model)
        configure(carPhotoCarouselView: carPhotoCarouselView)
    }
    
    func configure(carPhotoCarouselView: CarPhotoCarouselView) {
        view.addSubview(carPhotoCarouselView)
        configureConstrains(at: carPhotoCarouselView)
        updateLayout = { carPhotoCarouselView.reloadContent() }
    }
    
    func configureConstrains(at carPhotoCarouselView: CarPhotoCarouselView) {
        carPhotoCarouselView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
