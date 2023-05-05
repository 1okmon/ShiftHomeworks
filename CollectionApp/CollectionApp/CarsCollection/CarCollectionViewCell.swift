//
//  CarCollectionViewCell.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit
import SnapKit

fileprivate enum ImageViewMetrics {
    static let topOffset = 10
    static let width = 160
    static let height = 90
    static let backgroundColor = UIColor.gray.withAlphaComponent(0.4)
    static let cornerRadius: CGFloat = 15
    static let defaultImage = UIImage(systemName: "car")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
}

fileprivate enum LabelMetrics {
    static let topOffset = 5
    static let width = 160
    static let height = 40
    static let textAlignment: NSTextAlignment = .center
}

final class CarCollectionViewCell: UICollectionViewCell {
    var carModel: CarModel? {
        didSet {
            configure()
        }
    }
    private var carImageView = UIImageView()
    private var carNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CarCollectionViewCell {
    func configure() {
        configure(carImageView: carImageView)
        configure(carNameLabel: carNameLabel)
        guard let carModel = carModel else { return }
        configureContent(with: carModel)
    }
    
    
    func configure(carNameLabel: UILabel) {
        self.addSubview(carNameLabel)
        configureConstraint(at: carNameLabel, under: carImageView)
        configureView(at: carNameLabel)
    }
    
    func configure(carImageView: UIImageView) {
        self.addSubview(carImageView)
        configureConstraints(at: carImageView)
        configureView(at: carImageView)
    }
    
    func configureConstraints(at carImageView: UIImageView) {
        carImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(ImageViewMetrics.topOffset)
            make.width.equalTo(ImageViewMetrics.width)
            make.height.equalTo(ImageViewMetrics.height)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureView(at carImageView: UIImageView) {
        carImageView.layer.masksToBounds = true
        carImageView.backgroundColor = ImageViewMetrics.backgroundColor
        carImageView.layer.cornerRadius = ImageViewMetrics.cornerRadius
    }
    
    func configureView(at carNameLabel: UILabel) {
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
    
    func configureContent(with carModel: CarModel) {
        configureContent(at: carImageView, with: carModel)
        configureContent(at: carNameLabel, with: carModel)
    }
    
    func configureContent(at carImageView: UIImageView, with model: CarModel) {
        carImageView.contentMode = .scaleAspectFill
        guard let image = model.images?.first else {
            carImageView.image = ImageViewMetrics.defaultImage
            return
        }
        carImageView.image = image
    }
    
    func configureContent(at carNameLabel: UILabel, with model: CarModel) {
        carNameLabel.text = model.manufacturer + " " + model.model
    }
}
