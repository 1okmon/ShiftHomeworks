//
//  CharacterDetailsView.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor

    enum ImageView {
        static let verticalOffset = 30
        static let horizontalInset = 30
        static let height = 300
        static let tintColor = Theme.tintColor
        static let cornerRadius: CGFloat = 50
        static let defaultImage = UIImage(systemName: "person")
    }
    
    enum Label {
        static let textColor = Theme.textColor
        static let horizontalInset = 30
        static let height = 55
        static let verticalOffset = 5
        static let font = UIFont.systemFont(ofSize: 22)
        
        enum Prefix {
            static let name = "Имя:\t"
            static let status = "Статус:\t"
            static let species = "Вид:\t"
            static let gender = "Пол:\t"
            static let type = "Тип:\t"
        }
    }
}

final class CharacterDetailsView: UIView {
    private let characterImageView: UIImageView
    private let characterNameLabel: UILabel
    private let characterGenderLabel: UILabel
    private let characterStatusLabel: UILabel
    private let characterSpeciesLabel: UILabel
    private let characterTypeLabel: UILabel
    
    init() {
        self.characterImageView = UIImageView()
        self.characterNameLabel = UILabel()
        self.characterGenderLabel = UILabel()
        self.characterStatusLabel = UILabel()
        self.characterSpeciesLabel = UILabel()
        self.characterTypeLabel = UILabel()
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with character: CharacterDetails) {
        self.characterImageView.image = character.image ?? Metrics.ImageView.defaultImage
        self.characterNameLabel.text = Metrics.Label.Prefix.name + character.name
        self.characterGenderLabel.text = Metrics.Label.Prefix.gender + character.gender
        self.characterStatusLabel.text = Metrics.Label.Prefix.status + character.status
        self.characterSpeciesLabel.text = Metrics.Label.Prefix.species + character.species
        self.characterTypeLabel.isHidden = character.type.isEmpty
        self.characterTypeLabel.text = Metrics.Label.Prefix.type + character.type
    }
}

private extension CharacterDetailsView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureCharacterImageView()
        configure(label: self.characterNameLabel, under: self.characterImageView)
        configure(label: self.characterGenderLabel, under: self.characterNameLabel)
        configure(label: self.characterStatusLabel, under: self.characterGenderLabel)
        configure(label: self.characterSpeciesLabel, under: self.characterStatusLabel)
        configure(label: self.characterTypeLabel, under: self.characterSpeciesLabel)
    }
    
    func configure(label: UILabel, under view: UIView? = nil) {
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(Metrics.Label.horizontalInset)
            make.height.equalTo(Metrics.Label.height)
            if let view = view {
                make.top.equalTo(view.snp.bottom).offset(Metrics.Label.verticalOffset)
            } else {
                make.top.equalToSuperview().offset(Metrics.Label.verticalOffset)
            }
        }
        label.numberOfLines = 0
        label.textColor = Metrics.Label.textColor
        label.font = Metrics.Label.font
    }
    
    func configureCharacterImageView() {
        self.addSubview(self.characterImageView)
        self.characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Metrics.ImageView.verticalOffset)
            make.trailing.leading.equalToSuperview().inset(Metrics.ImageView.horizontalInset)
            make.height.equalTo(Metrics.ImageView.height)
        }
        self.characterImageView.layer.cornerRadius = Metrics.ImageView.cornerRadius
        self.characterImageView.tintColor = Metrics.ImageView.tintColor
        self.characterImageView.image = Metrics.ImageView.defaultImage
        self.characterImageView.layer.masksToBounds = true
        self.characterImageView.contentMode = .scaleAspectFill
    }
}
