//
//  ImagesTableViewCell.swift
//  homework7
//
//  Created by 1okmon on 26.05.2023.
//

import UIKit

private enum Metrics {
    enum ActivityView {
        static let backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    enum Error {
        static let titleTrailingInset = 20
        static let titleHeight = 80
        static let titleText = "Не удалось загрузить картинку. Нажмите, чтобы выбрать действие."
        static let titleTextAlignment = NSTextAlignment.center
    }
    
    enum ImageView {
        static let height = 150
        static let trailingInset = 10
        static let pauseImage = UIImage(systemName: "pause")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    }
    
    enum ProgressView {
        static let height = 10
        static let cornerRadius: CGFloat = 2
        static let borderWidth: CGFloat = 1
        static let borderColor = UIColor.black.cgColor
        static let progressTintColor = UIColor.green
        static let trackTintColor = UIColor.clear
    }
}

final class ImageLoadingTableViewCell: UITableViewCell {
    var state: LoadingState {
        didSet {
            loadedImageView.image = nil
            switch state {
            case .loaded(let image):
                setImage(image: image)
            case .loading(let progress):
                showActivityIndicator()
                setProgress(progress)
            case .paused:
                showPause()
            case .error:
                errorView.isHidden = false
                makeActivityAndProgressVisible(false)
            }
        }
    }
    private var loadedImageView: UIImageView
    private var progressView: UIProgressView
    private var errorView: UIView
    private var activityView: UIView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.loadedImageView = UIImageView()
        self.progressView = UIProgressView()
        self.errorView = UIView()
        self.activityView = UIView()
        self.state = .loading(progress: 0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    override func prepareForReuse() {
        self.errorView.isHidden = true
        loadedImageView.image = nil
        progressView.progress = 0
    }
    
    func setProgress(_ progress: Float) {
        self.progressView.progress = Float(progress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: items configurations extension
private extension ImageLoadingTableViewCell {
    func configure() {
        configureImage()
        configureProgressView()
        configureAlertView()
        configureActivityView()
    }
    
    func configureActivityView() {
        self.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityView.backgroundColor = Metrics.ActivityView.backgroundColor
        configureActivityIndicatorView(for: activityView)
    }
    
    func configureImage() {
        self.addSubview(loadedImageView)
        loadedImageView.snp.makeConstraints { make in
            make.height.equalTo(Metrics.ImageView.height)
            make.leading.trailing.top.equalToSuperview().inset(Metrics.ImageView.trailingInset)
        }
        loadedImageView.contentMode = .scaleAspectFit
    }
    
    func configureAlertView() {
        self.addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configureItemsInErrorView()
        errorView.isHidden = true
    }
    
    func configureActivityIndicatorView(for view: UIView) {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicatorView.startAnimating()
    }
    
    func configureProgressView() {
        self.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(loadedImageView.snp.bottom)
            make.trailing.leading.equalTo(loadedImageView)
            make.height.equalTo(Metrics.ProgressView.height)
        }
        progressView.layer.cornerRadius = Metrics.ProgressView.cornerRadius
        progressView.layer.borderWidth = Metrics.ProgressView.borderWidth
        progressView.layer.borderColor = Metrics.ProgressView.borderColor
        progressView.progressTintColor = Metrics.ProgressView.progressTintColor
        progressView.trackTintColor = Metrics.ProgressView.trackTintColor
    }
    
    func configureItemsInErrorView() {
        let titleLabel = UILabel()
        errorView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Metrics.Error.titleTrailingInset)
            make.height.equalTo(Metrics.Error.titleHeight)
        }
        titleLabel.text = Metrics.Error.titleText
        titleLabel.textAlignment = Metrics.Error.titleTextAlignment
    }
}

// MARK: methods extension
private extension ImageLoadingTableViewCell {
    func showPause() {
        loadedImageView.image = Metrics.ImageView.pauseImage
        makeActivityAndProgressVisible(false)
    }
    
    func makeActivityAndProgressVisible(_ isVisible: Bool) {
        progressView.isHidden = !isVisible
        activityView.isHidden = !isVisible
    }
    
    func setImage(image: UIImage) {
        self.loadedImageView.image = image
        makeActivityAndProgressVisible(false)
    }
    
    func showActivityIndicator() {
        if activityView.isHidden {
            makeActivityAndProgressVisible(true)
        }
    }
}
