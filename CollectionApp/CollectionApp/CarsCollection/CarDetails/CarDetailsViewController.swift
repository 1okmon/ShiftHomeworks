//
//  CarDetailsViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit
import SnapKit

fileprivate enum ViewControllerMetrics {
    static let viewBackgroundColor = UIColor.white
}

final class CarDetailsViewController: UIViewController {
    var carModel: CarDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension CarDetailsViewController {
    func configure() {
        view.backgroundColor = ViewControllerMetrics.viewBackgroundColor
        guard let carModel = carModel else { return }
        let carDetailsView = CarDetailsView(model: carModel)
        configure(carDetailsView: carDetailsView)
    }
    
    func configureContent(with model: CarModel) {
        title = model.fullName
    }
    
    func configure(carDetailsView: CarDetailsView) {
        view.addSubview(carDetailsView)
        configureConstraints(at: carDetailsView)
    }
    
    func configureConstraints(at carDetailsView: CarDetailsView) {
        carDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
