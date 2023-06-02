//
//  FavoritesView.swift
//  FinalProject
//
//  Created by 1okmon on 02.06.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    
    enum Button {
        
    }
}

final class FavoritesView: UIView {
    private var locationsButton: UIButton

    init() {
        self.locationsButton = UIButton(type: .system)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FavoritesView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureLocationsButton()
    }
    
    func configureLocationsButton() {
        self.addSubview(self.locationsButton)
        self.locationsButton.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        self.locationsButton.layer.borderWidth = 2
        self.locationsButton.layer.borderWidth = 5
        self.locationsButton.setTitle("Locations", for: .normal)
    }
}
