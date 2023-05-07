//
//  CarDetailsView.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

fileprivate enum ImageViewMetrics {
    static let topOffset = 15
    static let height = 200
}

fileprivate enum LabelMetrics {
    static let topOffset = 30
    static let leadingOffset = 20
    static let trailingInset = 20
    static let height = 60
    static let bottomInset = 15
}

fileprivate enum ViewMetrics {
    static let backgroundColor = UIColor.white
}

final class CarDetailsView: UIView, UIScrollViewDelegate {
    var carModel: CarDetailModel?
    private let carImageView = UIImageView()
    private let carNameLabel = UILabel()
    private let carYearOfIssueLabel = UILabel()
    private let scrollView = UIScrollView()
    
    required init(model: CarDetailModel) {
        self.carModel = model
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CarDetailsView {
    func configure() {
        self.backgroundColor = ViewMetrics.backgroundColor
        configure(scrollView: scrollView)
        configure(carImageView: carImageView)
        configure(label: carNameLabel, upperView: carImageView, textAlignment: .center)
        configure(label: carYearOfIssueLabel, upperView: carNameLabel)
        guard let carModel = carModel else { return }
        configureContent(with: carModel)
        configureContentViewBottomConstraint(at: scrollView, bottomView: carYearOfIssueLabel)
    }
    
    func configureContentViewBottomConstraint(at scrollView: UIScrollView, bottomView: UIView) {
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(LabelMetrics.bottomInset)
        }
    }
    
    func configureContent(with model: CarDetailModel) {
        configureContent(at: carImageView, with: model.carPhoto)
        configureContent(at: carNameLabel, with: model.fullName)
        configureContent(at: carYearOfIssueLabel, with: model.yearOfIssue)
    }
    
    func configureContent(at carImageView: UIImageView, with image: UIImage?) {
        guard let image = image else {
            carImageView.image = Images.defaultForCar
            return
        }
        carImageView.image = image
    }
    
    func configureContent(at label: UILabel, with text: String) {
        label.text = text
    }
    
    func configure(scrollView: UIScrollView) {
        self.addSubview(scrollView)
        configureConstraints(at: scrollView)
        configureDelegates(at: scrollView)
    }

    func configureConstraints(at scrollView: UIScrollView) {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureDelegates(at scrollView: UIScrollView) {
        scrollView.delegate = self
    }
    
    func configure(carImageView: UIImageView) {
        scrollView.addSubview(carImageView)
        configureConstraints(at: carImageView)
        configureUI(at: carImageView)
        configureGestureRecognizer(at: carImageView)
    }
    
    func configureConstraints(at carImageView: UIImageView) {
        carImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(ImageViewMetrics.topOffset)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(ImageViewMetrics.height)
        }
    }
    
    func configureUI(at carImageView: UIImageView) {
        carImageView.contentMode = .scaleAspectFit
    }
    
    func configureGestureRecognizer(at carImageView: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        carImageView.isUserInteractionEnabled = true
        carImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let parentViewController = self.parentViewController
        let carPhotoCarouselViewController = CarPhotoCarouselViewController()
        let navController = UINavigationController(rootViewController: carPhotoCarouselViewController)
        carPhotoCarouselViewController.model = carModel?.carPhotosForCarouselModel
        navController.modalPresentationStyle = .fullScreen
        parentViewController?.present(navController, animated: true)
    }
    
    func configure(label: UILabel, upperView: UIView, textAlignment: NSTextAlignment = .left) {
        scrollView.addSubview(label)
        configureConstraints(at: label, upperView: upperView)
        configureUI(at: label, textAlignment: textAlignment)
    }
    
    func configureConstraints(at label: UILabel, upperView: UIView) {
        label.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(LabelMetrics.topOffset)
            make.leading.equalTo(self).offset(LabelMetrics.leadingOffset)
            make.trailing.equalTo(self).inset(LabelMetrics.trailingInset)
            make.height.equalTo(LabelMetrics.height)
        }
    }
    
    func configureUI(at label: UILabel, textAlignment: NSTextAlignment) {
        label.textAlignment = textAlignment
        label.font = Fonts.defaultForLabel
        label.numberOfLines = 0
    }
}
