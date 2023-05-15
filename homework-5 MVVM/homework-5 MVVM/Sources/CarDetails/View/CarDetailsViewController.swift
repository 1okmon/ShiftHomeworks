//
//  CarDetailsViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit
import SnapKit

private enum Metrics {
    static let viewBackgroundColor = UIColor.white
}

final class CarDetailsViewController: UIViewController {
    var viewModel: ICarDetailsViewModel
    
    init(viewModel: ICarDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension CarDetailsViewController {
    func configure() {
        view.backgroundColor = Metrics.viewBackgroundColor
        //guard let carDetailsViewModel = viewModel else { return }
        let carDetailsView = CarDetailsView(viewModel: viewModel)
        configure(carDetailsView: carDetailsView)
    }
    
    func configureContent(with model: CarModel) {
        title = model.fullName
    }
    
    func configure(carDetailsView: CarDetailsView) {
        view.addSubview(carDetailsView)
        carDetailsView.imageTapHandler = { [weak self] in
            guard let car = self?.viewModel.car else { return }
            self?.viewModel.goToCarPhotoCarousel(with: car)
        }
        configureConstraints(at: carDetailsView)
    }
    
    func configureConstraints(at carDetailsView: CarDetailsView) {
        carDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
