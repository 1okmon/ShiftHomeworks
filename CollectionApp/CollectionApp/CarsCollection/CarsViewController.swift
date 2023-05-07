//
//  CarsViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

fileprivate enum Cars: CaseIterable {
    case skylineR34
    case skylineR35
    case supraA80
    case supraA90
    case silviaS13
    case silviaS14
    case silviaS15
    case silviaS15Boss
    case z370BadAssVRZ
    case miata
    
    var carModel: CarModel {
        switch self {
        case .skylineR34:
            return CarModel(manufacturer: "Nissan",
                            model: "GT-R r34",
                            images: [UIImage(named: "skylineR34-1"),
                                     UIImage(named: "skylineR34-2"),
                                     UIImage(named: "skylineR34-3")])
        case .skylineR35:
            return CarModel(manufacturer: "Nissan",
                            model: "GT-R",
                            images: [UIImage(named: "skylineR35-1"),
                                     UIImage(named: "skylineR35-2")])
        case .supraA80:
            return CarModel(manufacturer: "Toyota",
                            model: "Supra A80",
                            images: [UIImage(named: "supraA80-1")])
        case .supraA90:
            return CarModel(manufacturer: "Toyota",
                            model: "Supra A90",
                            images: [UIImage(named: "supraA90-1")])
        case .silviaS13:
            return CarModel(manufacturer: "Nissan",
                            model: "Silvia S13",
                            images: [UIImage(named: "silviaS13-1"),
                                     UIImage(named: "silviaS13-2")])
        case .silviaS14:
            return CarModel(manufacturer: "Nissan",
                            model: "Silvia S14",
                            images: [UIImage(named: "silviaS14-1")])
        case .silviaS15:
            return CarModel(manufacturer: "Nissan",
                            model: "Silvia S15",
                            images: [UIImage(named: "silviaS15-1"),
                                     UIImage(named: "silviaS15-2")])
        case .silviaS15Boss:
            return CarModel(manufacturer: "Nissan",
                            model: "Silvia S15 rocket bunny boss",
                            images: [UIImage(named: "silviaS15Boss-1"),
                                     UIImage(named: "silviaS15Boss-2")])
        case .z370BadAssVRZ:
            return CarModel(manufacturer: "Nissan",
                            model: "370Z BadAss VR-Z",
                            images: [UIImage(named: "z370BadAssVRZ-1"),
                                     UIImage(named: "z370BadAssVRZ-2")])
        case .miata:
            return CarModel(manufacturer: "Mazda",
                            model: "MX-5 miata",
                            images: [UIImage(named: "miata-1"),
                                     UIImage(named: "miata-2"),
                                     UIImage(named: "miata-3")])
        }
    }
    
    static var allCarModels: [CarModel] {
        var carModels = [CarModel]()
        for car in Cars.allCases {
            carModels.append(car.carModel)
        }
        return carModels
    }
}

fileprivate enum ViewControllerMetrics {
    static let title = "Cars list"
    static let viewBackgroundColor = UIColor.white
}

final class CarsViewController: UIViewController {
    private var configureLayout: (()->()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

private extension CarsViewController {
    func configure() {
        let carsView = CarsView(carModels: Cars.allCarModels)
        title = ViewControllerMetrics.title
        configure(view: view)
        configure(carsView: carsView)
    }
    
    func configure(carsView: CarsView) {
        view.addSubview(carsView)
        configureConstraints(at: carsView)
        configureLayout = {
            carsView.updateLayout()
        }
    }
    
    func configureConstraints(at carsView: CarsView) {
        carsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configure(view: UIView) {
        view.backgroundColor = ViewControllerMetrics.viewBackgroundColor
    }
}
