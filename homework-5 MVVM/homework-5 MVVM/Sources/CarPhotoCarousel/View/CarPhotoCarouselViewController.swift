//
//  CarPhotoCarouselViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

private enum Metrics {
    static let leftBarButtonItemTitle = "Close"
}

final class CarPhotoCarouselViewController: UIViewController, IObserver {
    var id: UUID
    private var viewModel: ICarPhotoCarouselViewModel
    private var updateLayout: (()->())?
    let carPhotoCarouselView: CarPhotoCarouselView
    
    init(viewModel: ICarPhotoCarouselViewModel) {
        self.id = UUID()
        self.viewModel = viewModel
        self.carPhotoCarouselView = CarPhotoCarouselView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(
            title: Metrics.leftBarButtonItemTitle,
            style: .done,
            target: self,
            action: #selector(dismissPhotoCarousel))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let updateLayout = self.updateLayout else { return }
        updateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func update<T>(with value: T) {
        guard let car = value as? CarPhotoCarouselModel else { return }
        self.carPhotoCarouselView.updateContent(with: car.images)
    }
}

extension CarPhotoCarouselViewController {
    @objc func dismissPhotoCarousel() {
        self.viewModel.dismiss()
    }
    
    func configure() {
        configure(carPhotoCarouselView: carPhotoCarouselView)
    }
    
    func configure(carPhotoCarouselView: CarPhotoCarouselView) {
        view.addSubview(carPhotoCarouselView)
        configureConstrains(at: carPhotoCarouselView)
        self.updateLayout = { [weak self] in
            self?.carPhotoCarouselView.reloadLayout()
        }
    }
    
    func configureConstrains(at carPhotoCarouselView: CarPhotoCarouselView) {
        carPhotoCarouselView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
