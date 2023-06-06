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
        static let edgeInset = 10
        static let titleColor = UIColor.white
        static let font = UIFont.systemFont(ofSize: 24)
        static let imageAlpha: CGFloat = 0.4
    }
}

private enum FavoriteButtonType {
    case locations
    case characters
    
    var title: String {
        switch self {
        case .characters:
            return "Персонажи"
        case .locations:
            return "Локации"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .characters:
            return UIImage(named: "characters")
        case .locations:
            return UIImage(named: "locations")
        }
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
    
    func configureContentMode() {
        self.locationsButton.subviews.first?.contentMode = .scaleAspectFit
        self.charactersButton.subviews.first?.contentMode = .scaleAspectFit
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
            make.leading.trailing.top.equalToSuperview().inset(Metrics.Button.edgeInset)
            make.bottom.equalTo(self.snp.centerY)
        }
        configureLayer(at: self.locationsButton, type: .locations)
        self.locationsButton.addTarget(self, action: #selector(locationsButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureCharactersButton() {
        self.addSubview(self.charactersButton)
        self.charactersButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(Metrics.Button.edgeInset)
            make.top.equalTo(self.locationsButton.snp.bottom)
        }
        configureLayer(at: self.charactersButton, type: .characters)
        self.charactersButton.addTarget(self, action: #selector(charactersButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureLayer(at button: UIButton, type: FavoriteButtonType) {
        button.setBackgroundImage(type.image?.withAlpha(Metrics.Button.imageAlpha), for: .normal)
        button.setTitle(type.title, for: .normal)
        button.titleLabel?.font = Metrics.Button.font
        button.setTitleColor(Metrics.Button.titleColor, for: .normal)
    }
    
    @objc func locationsButtonTapped(_ sender: UIButton) {
        self.locationsTapHandler?()
    }
    
    @objc func charactersButtonTapped(_ sender: UIButton) {
        self.charactersTapHandler?()
    }
}

extension UIImage {
    func withAlpha(_ alpha: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { _ in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: alpha)
        }
    }
}
