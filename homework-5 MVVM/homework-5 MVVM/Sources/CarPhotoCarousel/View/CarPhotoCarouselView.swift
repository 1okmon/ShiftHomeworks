//
//  CarPhotoCarouselView.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit
import SnapKit

private enum PhotoViewMetrics {
    static let imageViewContentMode = UIView.ContentMode.scaleAspectFit
    static var prevViewWidth = UIScreen.main.bounds.width
    static var photoViewSize: (width: CGFloat, height: CGFloat) {
        switch UIDevice.current.orientation {
        case .portrait:
            return (UIScreen.main.bounds.width, UIScreen.main.bounds.width)
        default:
            return (UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        }
    }
}

private enum ViewMetrics {
    static let backgroundColor = UIColor.black
}

final class CarPhotoCarouselView: UIView {
    private var viewModel: ICarPhotoCarouselViewModel
    private var carPhotoViews = [UIView]()
    private var scrollView = UIScrollView()
    private var scrollViewContentSize: (width: CGFloat, height: CGFloat) {
        switch UIDevice.current.orientation {
        case .portrait:
            return (UIScreen.main.bounds.width * CGFloat(self.carPhotoViews.count),
                    UIScreen.main.bounds.width)
        default:
            return (UIScreen.main.bounds.width * CGFloat(self.carPhotoViews.count),
                    UIScreen.main.bounds.height)
        }
    }
    
    required init(viewModel: ICarPhotoCarouselViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
        reloadContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadContent() {
        configure(carPhotoViews: &self.carPhotoViews)
        updateContent(at: self.scrollView)
    }
}

private extension CarPhotoCarouselView {
    func configure() {
        self.layoutIfNeeded()
        self.backgroundColor = ViewMetrics.backgroundColor
        configure(scrollView: self.scrollView)
    }
    
    func viewForCarousel(image: UIImage) -> UIView {
        let viewForCarousel = UIView()
        configureUI(viewForCarousel: viewForCarousel, with: image)
        return viewForCarousel
    }
    
    func configureUI(viewForCarousel: UIView, with image: UIImage) {
        viewForCarousel.frame = CGRect(x: 0, y: 0, width: PhotoViewMetrics.photoViewSize.width, height: PhotoViewMetrics.photoViewSize.height)
        let imageView = UIImageView()
        configure(imageView: imageView, for: viewForCarousel, with: image)
    }
    
    func configure(imageView: UIImageView, for viewForCarousel: UIView, with image: UIImage) {
        viewForCarousel.addSubview(imageView)
        configureUI(at: imageView, with: image)
        configureConstraints(at: imageView)
    }
    
    func configureUI(at imageView: UIImageView, with image: UIImage) {
        imageView.image = image
        imageView.contentMode = PhotoViewMetrics.imageViewContentMode
    }
    
    func configureConstraints(at imageView: UIImageView) {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(carPhotoViews: inout [UIView]) {
        if let view = carPhotoViews.first {
            PhotoViewMetrics.prevViewWidth = view.frame.width
        }
        carPhotoViews.removeAll()
        self.viewModel.images?.forEach {
            if let image = $0 {
                carPhotoViews.append(viewForCarousel(image: image))
            }
        }
    }
    
    func updateContent(at scrollView: UIScrollView) {
        updateConstraints(at: scrollView)
        let currentPage = round(scrollView.contentOffset.x / PhotoViewMetrics.prevViewWidth)
        scrollView.subviews.forEach { $0.removeFromSuperview()}
        configureContent(at: scrollView)
        updateContentOffset(at: scrollView, to: currentPage)
    }
    
    func configureContent(at scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(
            width: self.scrollViewContentSize.width,
            height: self.scrollViewContentSize.height)
        for i in 0 ..< self.carPhotoViews.count {
            self.carPhotoViews[i].frame = CGRect(
                x: PhotoViewMetrics.photoViewSize.width * CGFloat(i),
                y: 0,
                width: PhotoViewMetrics.photoViewSize.width,
                height: PhotoViewMetrics.photoViewSize.height)
            scrollView.addSubview(self.carPhotoViews[i])
        }
    }
    
    func updateContentOffset(at scrollView: UIScrollView, to page: CGFloat) {
        DispatchQueue.main.async {
            scrollView.contentOffset.x = page * PhotoViewMetrics.photoViewSize.width
        }
    }
    
    func updateConstraints(at scrollView: UIScrollView) {
        scrollView.snp.updateConstraints { make in
            make.height.equalTo(PhotoViewMetrics.photoViewSize.height)
        }
    }
    
    func configure(scrollView: UIScrollView) {
        self.addSubview(scrollView)
        configureConstraints(at: scrollView)
        configureDelegate(at: scrollView)
        configureUI(at: scrollView)
    }
    
    func configureConstraints(at scrollView: UIScrollView) {
        scrollView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(PhotoViewMetrics.photoViewSize.height)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureUI(at scrollView: UIScrollView) {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = .zero
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
    }
    
    func configureDelegate(at scrollView: UIScrollView) {
        scrollView.delegate = self
    }
    
}

extension CarPhotoCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}
