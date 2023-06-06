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
    var locationsTapHandler: (() -> Void)?
    var charactersTapHandler: (() -> Void)?
    private var locationsButton: UIButton
    private var charactersButton: UIButton
    
    init() {
        self.locationsButton = UIButton(type: .system)
        self.charactersButton = UIButton(type: .system)
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
        configureCharactersButton()
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
        self.locationsButton.addTarget(self, action: #selector(locationsButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureCharactersButton() {
        self.addSubview(self.charactersButton)
        self.charactersButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.locationsButton.snp.bottom)
        }
        self.charactersButton.layer.borderWidth = 2
        self.charactersButton.layer.borderWidth = 5
        self.charactersButton.setTitle("Locations", for: .normal)
        self.charactersButton.addTarget(self, action: #selector(charactersButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func locationsButtonTapped(_ sender: UIButton) {
        self.locationsTapHandler?()
    }
    
    @objc func charactersButtonTapped(_ sender: UIButton) {
        self.charactersTapHandler?()
    }
}
