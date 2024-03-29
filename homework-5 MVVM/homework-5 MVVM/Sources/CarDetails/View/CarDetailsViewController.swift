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

final class CarDetailsViewController: UIViewController, IObserver {
    var id: UUID
    private var viewModel: ICarDetailsViewModel
    private let carDetailsView: CarDetailsView
    
    init(viewModel: ICarDetailsViewModel) {
        self.id = UUID()
        self.viewModel = viewModel
        self.carDetailsView = CarDetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func update<T>(with value: T) {
        guard let car = value as? CarDetailModel else { return }
        self.title = car.fullName
        self.carDetailsView.updateContent(with: car)
    }
}

private extension CarDetailsViewController {
    func configure() {
        view.backgroundColor = Metrics.viewBackgroundColor
        configureCarDetailsView()
    }
    
    func configureCarDetailsView() {
        self.view.addSubview(self.carDetailsView)
        self.carDetailsView.imageTapHandler = { [weak self] carId in
            self?.viewModel.goToCarPhotoCarousel(with: carId)
        }
        self.configureCarDetailsViewConstraints()
    }
    
    func configureCarDetailsViewConstraints() {
        self.carDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
