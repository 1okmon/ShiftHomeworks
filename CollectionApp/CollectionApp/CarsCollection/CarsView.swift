//
//  CarsView.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

fileprivate enum CollectionLayout {
    static let portrait = ColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 8,
        minimumLineSpacing: 8,
        sectionInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    static let landscape = ColumnFlowLayout(
        cellsPerRow: 4,
        minimumInteritemSpacing: 8,
        minimumLineSpacing: 8,
        sectionInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    
    static var layout: ColumnFlowLayout {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            return portrait
        case .landscapeLeft, .landscapeRight:
            return landscape
        default:
            return portrait
        }
    }
}

fileprivate enum ViewMetrics {
    static let backgroundColor = UIColor.white
}

final class CarsView: UIView {
    private var carModels: [CarModel]
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CollectionLayout.layout)
    private let cellDequeueConfig = UICollectionView.CellRegistration<CarCollectionViewCell, CarModel> { (cell, indexPath, carModel) in
        cell.carModel = carModel
    }

    required init(carModels: [CarModel]) {
        self.carModels = carModels
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayout() {
        configureLayout(at: collectionView)
    }
}

private extension CarsView {
    func configure() {
        self.backgroundColor = ViewMetrics.backgroundColor
        configure(collectionView: collectionView)
    }
    
    func configure(collectionView: UICollectionView) {
        self.addSubview(collectionView)
        configureConstraints(at: collectionView)
        configureLayout(at: collectionView)
        configureCells(at: collectionView)
        configureDelegates(at: collectionView)
    }
    
    func configureCells(at collectionView: UICollectionView) {
        collectionView.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: CarCollectionViewCell.className)
    }
    
    func configureDelegates(at collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureConstraints(at collectionView: UICollectionView) {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureLayout(at collectionView: UICollectionView) {
        collectionView.collectionViewLayout = CollectionLayout.layout
        collectionView.reloadData()
    }
}

extension CarsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: cellDequeueConfig,
            for: indexPath,
            item: carModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let carDetailsViewController = CarDetailsViewController()
        let model = carModels[indexPath.row]
        let carDetailModel = CarDetailModel(fullName: model.fullName,
                                            yearOfIssue: model.yearOfIssueDescription,
                                            carPhoto: model.images?.first ?? Images.defaultForCar,
                                            carPhotosForCarouselModel:
                                                CarPhotosForCarouselModel(images: model.images))
        carDetailsViewController.carModel = carDetailModel
        let parentViewController = self.parentViewController
        parentViewController?.navigationController?.pushViewController(carDetailsViewController, animated: true)
    }
}
