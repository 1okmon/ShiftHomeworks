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
        self.configureCarImageView()
        self.configureCarNameLabel()
        guard let car = self.car else { return }
        self.configureContent(with: car)
    }
    
    func configureCarNameLabel() {
        self.addSubview(self.carNameLabel)
        self.configureCarNameLabelConstraints()
        self.configureCarNameLabelUI()
    }
    
    func configureCarNameLabelConstraints() {
        self.carNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.carImageView.snp.bottom).offset(LabelMetrics.topOffset)
            make.width.equalTo(LabelMetrics.width)
            make.height.greaterThanOrEqualTo(LabelMetrics.height)
            make.centerX.equalTo(self.carImageView)
        }
    }
    
    func configureCarNameLabelUI() {
        self.carNameLabel.numberOfLines = 0
        self.carNameLabel.textAlignment = LabelMetrics.textAlignment
    }
    
    func configureCarImageView() {
        self.addSubview(self.carImageView)
        self.configureCarImageViewConstraints()
        self.configureCarImageViewUI()
    }
    
    func configureCarImageViewConstraints() {
        self.carImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ImageViewMetrics.topOffset)
            make.width.equalTo(ImageViewMetrics.width)
            make.height.equalTo(ImageViewMetrics.height)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureCarImageViewUI() {
        self.carImageView.layer.masksToBounds = true
        self.carImageView.backgroundColor = ImageViewMetrics.backgroundColor
        self.carImageView.layer.cornerRadius = ImageViewMetrics.cornerRadius
    }
    
    func configureContent(with car: CarModel) {
        self.configureCarImageViewContent(with: car)
        self.configureCarNameLabelContent(with: car)
    }
    
    func configureCarImageViewContent(with car: CarModel) {
        self.carImageView.contentMode = .scaleAspectFill
        guard let image = car.images?.first else {
            self.carImageView.image = ImageViewMetrics.defaultImage
            return
        }
        self.carImageView.image = image
    }
    
    func configureCarNameLabelContent(with car: CarModel) {
        self.carNameLabel.text = car.fullName
    }
}
