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
    var imageTapHandler: (()->Void) = {}
    private var viewModel: ICarDetailsViewModel
    private let carImageView = UIImageView()
    private let carNameLabel = UILabel()
    private let carYearOfIssueLabel = UILabel()
    private let scrollView = UIScrollView()
    
    required init(viewModel: ICarDetailsViewModel) {
        self.viewModel = viewModel
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
        configure(scrollView: self.scrollView)
        configure(carImageView: self.carImageView)
        configure(label: self.carNameLabel, upperView: self.carImageView, textAlignment: .center)
        configure(label: self.carYearOfIssueLabel, upperView: self.carNameLabel)
        configureContent(with: self.viewModel)
        configureContentViewBottomConstraint(at: self.scrollView, bottomView: self.carYearOfIssueLabel)
    }
    
    func configureContentViewBottomConstraint(at scrollView: UIScrollView, bottomView: UIView) {
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(LabelMetrics.bottomInset)
        }
    }
    
    func configureContent(with viewModel: ICarDetailsViewModel) {
        configureContent(at: self.carImageView, with: viewModel.carPhoto)
        configureContent(at: self.carNameLabel, with: viewModel.fullName)
        configureContent(at: self.carYearOfIssueLabel, with: viewModel.yearOfIssue)
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
        self.scrollView.addSubview(carImageView)
        configureConstraints(at: carImageView)
        configureUI(at: carImageView)
        configureGestureRecognizer(at: carImageView)
    }
    
    func configureConstraints(at carImageView: UIImageView) {
        carImageView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top).offset(ImageViewMetrics.topOffset)
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
        self.imageTapHandler()
    }
    
    func configure(label: UILabel, upperView: UIView, textAlignment: NSTextAlignment = .left) {
        self.scrollView.addSubview(label)
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
