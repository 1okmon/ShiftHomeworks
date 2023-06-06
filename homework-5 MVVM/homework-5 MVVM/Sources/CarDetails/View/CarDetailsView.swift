//
//  CarDetailsView.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

private enum ImageViewMetrics {
    static let topOffset = 15
    static let height = 200
}

private enum LabelMetrics {
    static let topOffset = 30
    static let leadingOffset = 20
    static let trailingInset = 20
    static let height = 60
    static let bottomInset = 15
}

private enum ViewMetrics {
    static let backgroundColor = UIColor.white
}

final class CarDetailsView: UIView, UIScrollViewDelegate {
    var imageTapHandler: ((Int) -> Void)?
    private var car: CarDetailModel?
    private let carImageView = UIImageView()
    private let carNameLabel = UILabel()
    private let carYearOfIssueLabel = UILabel()
    private let scrollView = UIScrollView()

    required init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateContent(with car: CarDetailModel) {
        self.car = car
        self.configureContent(with: car)
    }
}

private extension CarDetailsView {
    func configure() {
        self.backgroundColor = ViewMetrics.backgroundColor
        self.configureScrollView()
        self.configureCarImageView()
        self.configure(self.carNameLabel, under: self.carImageView, textAlignment: .center)
        self.configure(self.carYearOfIssueLabel, under: self.carNameLabel)
        self.configureScrollViewContentBottomConstraint()
    }
    
    func configureScrollViewContentBottomConstraint() {
        self.carYearOfIssueLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(LabelMetrics.bottomInset)
        }
    }
    
    func configureContent(with car: CarDetailModel) {
        self.configureCarImageViewContent(with: car.carPhoto)
        self.configureContent(at: self.carNameLabel, with: car.fullName)
        self.configureContent(at: self.carYearOfIssueLabel, with: car.yearOfIssueDescription)
    }
    
    func configureCarImageViewContent(with image: UIImage?) {
        guard let image = image else {
            self.carImageView.image = Images.defaultForCar
            return
        }
        self.carImageView.image = image
    }
    
    func configureContent(at label: UILabel, with text: String) {
        label.text = text
    }
    
    func configureScrollView() {
        self.addSubview(self.scrollView)
        self.configureScrollViewConstraints()
        self.scrollView.delegate = self
    }
    
    func configureScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCarImageView() {
        self.scrollView.addSubview(self.carImageView)
        self.configureCarImageViewConstraints()
        self.configureCarImageViewUI()
        self.configureCarImageViewGestureRecognizer()
    }
    
    func configureCarImageViewConstraints() {
        self.carImageView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top).offset(ImageViewMetrics.topOffset)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(ImageViewMetrics.height)
        }
    }
    
    func configureCarImageViewUI() {
        self.carImageView.contentMode = .scaleAspectFit
    }
    
    func configureCarImageViewGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        self.carImageView.isUserInteractionEnabled = true
        self.carImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let imageTapHandler = self.imageTapHandler,
              let carId = self.car?.id else { return }
        imageTapHandler(carId)
    }
    
    func configure(_ label: UILabel, under: UIView, textAlignment: NSTextAlignment = .left) {
        self.scrollView.addSubview(label)
        self.configureConstraints(at: label, under: under)
        self.configureUI(at: label, textAlignment: textAlignment)
    }
    
    func configureConstraints(at label: UILabel, under view: UIView) {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(LabelMetrics.topOffset)
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
