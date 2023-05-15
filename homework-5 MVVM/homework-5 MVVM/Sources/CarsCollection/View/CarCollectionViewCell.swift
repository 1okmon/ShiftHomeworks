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
    static let defaultImage = Images.defaultForCar
}

fileprivate enum LabelMetrics {
    static let topOffset = 5
    static let width = 160
    static let height = 40
    static let textAlignment: NSTextAlignment = .center
}

final class CarCollectionViewCell: UICollectionViewCell {
    var viewModel: ICarViewModel? {
        didSet {
            configure()
        }
    }
    private var carImageView = UIImageView()
    private var carNameLabel = UILabel()
}

private extension CarCollectionViewCell {
    func configure() {
        configure(carImageView: carImageView)
        configure(carNameLabel: carNameLabel)
        guard let viewModel = viewModel else { return }
        configureContent(with: viewModel)
    }
    
    
    func configure(carNameLabel: UILabel) {
        self.addSubview(carNameLabel)
        configureConstraint(at: carNameLabel, under: carImageView)
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
    
    func configureContent(with viewModel: ICarViewModel) {
        configureContent(at: carImageView, with: viewModel)
        configureContent(at: carNameLabel, with: viewModel)
    }
    
    func configureContent(at carImageView: UIImageView, with viewModel: ICarViewModel) {
        carImageView.contentMode = .scaleAspectFill
        guard let image = viewModel.images?.first else {
            carImageView.image = ImageViewMetrics.defaultImage
            return
        }
        carImageView.image = image
    }
    
    func configureContent(at carNameLabel: UILabel, with viewModel: ICarViewModel) {
        carNameLabel.text = viewModel.fullName
    }
}
