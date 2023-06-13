//
//  ActivityView.swift
//  FinalProject
//
//  Created by 1okmon on 08.06.2023.
//

import UIKit

private enum Metrics {
    static let activityViewBackgroundColor = Theme.backgroundColor.withAlphaComponent(0.8)
    static let activityIndicatorVerticalOffset = -50
}

final class ActivityView: UIView {
    private var activityIndicatorView: UIActivityIndicatorView
    
    init(superview: UIView) {
        self.activityIndicatorView = UIActivityIndicatorView(style: .large)
        super.init(frame: .zero)
        superview.addSubview(self)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        self.activityIndicatorView.startAnimating()
        self.isHidden = false
    }
    
    func stopAnimating() {
        self.isHidden = true
        self.activityIndicatorView.stopAnimating()
    }
    
    func deleteFromSuperview() {
        self.activityIndicatorView.removeFromSuperview()
        self.removeFromSuperview()
    }
}

private extension ActivityView {
    func configure() {
        self.isHidden = true
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.backgroundColor = Metrics.activityViewBackgroundColor
        configureActivityIndicatorView()
    }
    
    func configureActivityIndicatorView() {
        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
