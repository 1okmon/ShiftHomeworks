//
//  CharactersCollectionViewCell.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let verticalOffset = 5
    static let horizontalInset = 15
    static let backgroundColor = Theme.itemsBackgroundColor
    static let cornerRadius: CGFloat = 15
    
    enum Label {
        static let height = 30
        static let fontColor = Theme.textColor
        static let font = UIFont.systemFont(ofSize: 16)
    }
    
    enum ImageView {
        static let height = 100
        static let tintColor = Theme.tintColor
        static let cornerRadius: CGFloat = 10
        static let defaultImage = UIImage(systemName: "person")
    }
}

final class CharactersCollectionViewCell: UICollectionViewCell {
    private let characterImageView: UIImageView
    private let characterName: UILabel
    
    override init(frame: CGRect) {
        self.characterImageView = UIImageView()
        self.characterName = UILabel()
        super.init(frame: frame)
        //self.isUserInteractionEnabled = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with character: Character) {
        self.characterName.text = character.name
    }
    
    func update(with image: UIImage) {
        self.characterImageView.image = image
    }
    
    override func prepareForReuse() {
        //self.isUserInteractionEnabled = false
        self.characterImageView.image = Metrics.ImageView.defaultImage
    }
}

private extension CharactersCollectionViewCell {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        self.layer.cornerRadius = Metrics.cornerRadius
        configureCharacterImageView()
        configureCharacterName()
    }
    
    func configureCharacterImageView() {
        self.addSubview(self.characterImageView)
        self.characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Metrics.verticalOffset)
            make.trailing.leading.equalToSuperview().inset(Metrics.horizontalInset)
            make.height.equalTo(Metrics.ImageView.height)
        }
        self.characterImageView.layer.cornerRadius = Metrics.ImageView.cornerRadius
        self.characterImageView.tintColor = Metrics.ImageView.tintColor
        self.characterImageView.image = Metrics.ImageView.defaultImage
        self.characterImageView.layer.masksToBounds = true
        self.characterImageView.contentMode = .scaleAspectFill
    }
    
    func configureCharacterName() {
        self.addSubview(self.characterName)
        self.characterName.snp.makeConstraints { make in
            make.top.equalTo(self.characterImageView.snp.bottom).offset(Metrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Metrics.horizontalInset)
            make.height.equalTo(Metrics.Label.height)
        }
        self.characterName.textAlignment = .center
        self.characterName.font = Metrics.Label.font
        self.characterName.textColor = Metrics.Label.fontColor
    }
}
