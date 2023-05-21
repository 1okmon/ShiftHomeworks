//
//  CarCollectionViewCell.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit
import SnapKit

private enum ImageViewMetrics {
    static let topOffset = 10
    static let width = 160
    static let height = 90
    static let backgroundColor = UIColor.gray.withAlphaComponent(0.4)
    static let cornerRadius: CGFloat = 15
    static let defaultImage = Images.defaultForCar
}

private enum LabelMetrics {
    static let topOffset = 5
    static let width = 160
    static let height = 40
    static let textAlignment: NSTextAlignment = .center
}

final class CarCollectionViewCell: UICollectionViewCell {
    var car: CarModel? {
        didSet {
            configure()
        }
    }
    private var carImageView = UIImageView()
    private var carNameLabel = UILabel()
}

private extension CarCollectionViewCell {
    func configure() {
        configure(carImageView: self.carImageView)
        configure(carNameLabel: self.carNameLabel)
        guard let car = self.car else { return }
        configureContent(with: car)
    }
    
    func configure(carNameLabel: UILabel) {
        self.addSubview(carNameLabel)
        configureConstraint(at: carNameLabel, under: self.carImageView)
        configureUI(at: carNameLabel)
    }
    
    func configure(carImageView: UIImageView) {
        self.addSubview(carImageView)
        configureConstraints(at: carImageView)
        configureUI(at: carImageView)
    }
    
    func configureConstraints(at carImageView: UIImageView) {
        carImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(ImageViewMetrics.topOffset)
            make.width.equalTo(ImageViewMetrics.width)
            make.height.equalTo(ImageViewMetrics.height)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureUI(at carImageView: UIImageView) {
        carImageView.layer.masksToBounds = true
        carImageView.backgroundColor = ImageViewMetrics.backgroundColor
        carImageView.layer.cornerRadius = ImageViewMetrics.cornerRadius
    }
    
    func configureUI(at carNameLabel: UILabel) {
        carNameLabel.numberOfLines = 0
        carNameLabel.textAlignment = LabelMetrics.textAlignment
    }
    
    func configureConstraint(at carNameLabel: UILabel, under upperView: UIView) {
        carNameLabel.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(LabelMetrics.topOffset)
            make.width.equalTo(LabelMetrics.width)
            make.height.greaterThanOrEqualTo(LabelMetrics.height)
            make.centerX.equalTo(upperView)
        }
    }
    
    func configureContent(with car: CarModel) {
        configureContent(at: self.carImageView, with: car)
        configureContent(at: self.carNameLabel, with: car)
    }
    
    func configureContent(at carImageView: UIImageView, with car: CarModel) {
        carImageView.contentMode = .scaleAspectFill
        guard let image = car.images?.first else {
            carImageView.image = ImageViewMetrics.defaultImage
            return
        }
        carImageView.image = image
    }
    
    func configureContent(at carNameLabel: UILabel, with car: CarModel) {
        carNameLabel.text = car.fullName//.fullName
    }
}
