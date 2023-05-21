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
    private var carImages: [UIImage?]?
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
    
    init() {
        super.init(frame: .zero)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(with carImages: [UIImage?]?) {
        self.carImages = carImages
        self.reloadLayout()
    }
    
    func reloadLayout() {
        self.configureCarPhotoViews()
        self.updateScrollViewContent()
    }
}

private extension CarPhotoCarouselView {
    func configure() {
        self.layoutIfNeeded()
        self.backgroundColor = ViewMetrics.backgroundColor
        self.configureScrollView()
    }
    
    func configureScrollView() {
        self.addSubview(self.scrollView)
        self.configureScrollViewConstraints()
        self.scrollView.delegate = self
        self.configureScrollViewUI()
    }
    
    func configureScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(PhotoViewMetrics.photoViewSize.height)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureScrollViewUI() {
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentOffset = .zero
        self.scrollView.isScrollEnabled = true
        self.scrollView.isUserInteractionEnabled = true
    }
    
    func viewForCarousel(with image: UIImage) -> UIView {
        let viewForCarousel = UIView()
        self.configureUI(at: viewForCarousel, with: image)
        return viewForCarousel
    }
    
    func configureUI(at viewForCarousel: UIView, with image: UIImage) {
        viewForCarousel.frame = CGRect(x: 0, y: 0, width: PhotoViewMetrics.photoViewSize.width, height: PhotoViewMetrics.photoViewSize.height)
        let imageView = UIImageView()
        self.configure(imageView: imageView, for: viewForCarousel, with: image)
    }
    
    func configure(imageView: UIImageView, for viewForCarousel: UIView, with image: UIImage) {
        viewForCarousel.addSubview(imageView)
        imageView.image = image
        imageView.contentMode = PhotoViewMetrics.imageViewContentMode
        self.configureConstraints(at: imageView)
    }
    
    func configureConstraints(at imageView: UIImageView) {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCarPhotoViews() {
        if let view = carPhotoViews.first {
            PhotoViewMetrics.prevViewWidth = view.frame.width
        }
        self.carPhotoViews.removeAll()
        self.carImages?.forEach {
            if let image = $0 {
                self.carPhotoViews.append(self.viewForCarousel(with: image))
            }
        }
    }
    
    func updateScrollViewContent() {
        self.updateScrollViewConstraints()
        let currentPage = round(self.scrollView.contentOffset.x / PhotoViewMetrics.prevViewWidth)
        self.scrollView.subviews.forEach { $0.removeFromSuperview()}
        self.configureScrollViewContent()
        self.setScrollViewPage(to: currentPage)
    }
    
    func configureScrollViewContent() {
        self.scrollView.contentSize = CGSize(
            width: self.scrollViewContentSize.width,
            height: self.scrollViewContentSize.height)
        for i in 0 ..< self.carPhotoViews.count {
            self.carPhotoViews[i].frame = CGRect(
                x: PhotoViewMetrics.photoViewSize.width * CGFloat(i),
                y: 0,
                width: PhotoViewMetrics.photoViewSize.width,
                height: PhotoViewMetrics.photoViewSize.height)
            self.scrollView.addSubview(self.carPhotoViews[i])
        }
    }
    
    func setScrollViewPage(to page: CGFloat) {
        DispatchQueue.main.async {
            self.scrollView.contentOffset.x = page * PhotoViewMetrics.photoViewSize.width
        }
    }
    
    func updateScrollViewConstraints() {
        self.scrollView.snp.updateConstraints { make in
            make.height.equalTo(PhotoViewMetrics.photoViewSize.height)
        }
    }
}

extension CarPhotoCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}
