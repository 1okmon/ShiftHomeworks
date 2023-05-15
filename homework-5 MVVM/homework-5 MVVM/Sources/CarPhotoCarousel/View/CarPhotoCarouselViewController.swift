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
    private var viewModel: ICarPhotoCarouselViewModel
    private var updateLayout: (()->()) = {}
    
    init(viewModel: ICarPhotoCarouselViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.dismiss()
        //self.dismiss(animated: true, completion: nil)
    }
    
    func configure() {
        //guard let viewModel = viewModel else { return }
        let carPhotoCarouselView = CarPhotoCarouselView(viewModel: viewModel)
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
