//
//  CarsView.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

private enum CollectionLayout {
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
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height ? landscape : portrait
    }
}

private enum Metrics {
    static let viewBackgroundColor = UIColor.white
}

final class CarsView: UIView {
    var cellTapHandler: ((Int) -> Void)?
    private var carsData: [CarModel]?
    private var collectionView: UICollectionView
    private let cellDequeueConfig = UICollectionView.CellRegistration<CarCollectionViewCell, CarModel> { (cell, indexPath, car) in
        cell.car = car
    }
    
    required init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout.layout)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(with cars: [CarModel]) {
        self.carsData = cars
        self.collectionView.reloadData()
    }
    
    func updateLayout() {
        self.configureCollectionViewLayout()
    }
}

private extension CarsView {
    func configure() {
        self.backgroundColor = Metrics.viewBackgroundColor
        self.configureCollectionView()
    }
    
    func configureCollectionView() {
        self.addSubview(self.collectionView)
        self.configureCollectionViewConstraints()
        self.configureCollectionViewLayout()
        self.configureCollectionViewCells()
        self.configureCollectionViewDelegates()
    }
    
    func configureCollectionViewCells() {
        self.collectionView.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: CarCollectionViewCell.className)
    }
    
    func configureCollectionViewDelegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func configureCollectionViewConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCollectionViewLayout() {
        self.collectionView.collectionViewLayout = CollectionLayout.layout
        self.collectionView.reloadData()
    }
}

extension CarsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cars = self.carsData else { return 0 }
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cars = self.carsData else { return UICollectionViewCell() }
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: self.cellDequeueConfig,
            for: indexPath,
            item: cars[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellTapHandler = self.cellTapHandler,
              let cell = collectionView.cellForItem(at: indexPath) as? CarCollectionViewCell,
              let carId = cell.car?.id else { return }
        cellTapHandler(carId)
    }
}
