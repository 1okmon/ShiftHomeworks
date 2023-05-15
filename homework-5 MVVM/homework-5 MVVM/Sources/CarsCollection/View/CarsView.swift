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

private enum Metrics {
    static let viewBackgroundColor = UIColor.white
}

final class CarsView: UIView {
    private var viewModel: ICarsViewModel
    private var collectionView: UICollectionView
    private let cellDequeueConfig = UICollectionView.CellRegistration<CarCollectionViewCell, ICarViewModel> { (cell, indexPath, carViewModel) in
        cell.viewModel = carViewModel
    }
    
    required init(carsViewModel: ICarsViewModel) {
        self.viewModel = carsViewModel
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout.layout)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayout() {
        configureLayout(at: self.collectionView)
    }
}

private extension CarsView {
    func configure() {
        self.backgroundColor = Metrics.viewBackgroundColor
        configure(collectionView: self.collectionView)
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
        self.viewModel.allCarsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: self.cellDequeueConfig,
            for: indexPath,
            item: self.viewModel.allCarsViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.goToCarDetails(with: self.viewModel.allCarsViewModel[indexPath.row].car)
    }
}
