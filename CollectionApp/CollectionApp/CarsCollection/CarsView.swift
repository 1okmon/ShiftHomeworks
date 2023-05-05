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
        case .portrait:
            return portrait
        default:
            return landscape
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
    
    func updateLayout(orient: UIDeviceOrientation) {
        configureLayout(at: collectionView, with: UIDevice.current.orientation)
    }
}

private extension CarsView {
    func configure() {
        self.backgroundColor = ViewMetrics.backgroundColor
        configure(collectionView: collectionView)
    }
    
    func configure(collectionView: UICollectionView) {
        self.addSubview(collectionView)
        configureLayout(at: collectionView, with: UIDevice.current.orientation)
        configureCells(at: collectionView)
        configureConstraints(at: collectionView)
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
    
    func configureLayout(at collectionView: UICollectionView, with orient: UIDeviceOrientation) {
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
        carDetailsViewController.carModel = carModels[indexPath.row]
        let parentViewController = self.parentViewController
        parentViewController?.navigationController?.pushViewController(carDetailsViewController, animated: true)
    }
}
