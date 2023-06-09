//
//  LocationDetailsView.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit
import SnapKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    static let font = UIFont.systemFont(ofSize: 20)
    static let animationDuration = 0.5
    
    enum Label {
        static let textColor = Theme.textColor
        static let horizontalInset = 30
        static let height = 60
        static let verticalOffset = 10
        
        enum Prefix {
            static let name = "Имя локации:\n\t"
            static let type = "Тип локации:\n\t"
            static let dimension = "Измерение:\n\t"
            static let residentsCount = "Количество жителей:\n\t"
        }
    }
    
    enum Button {
        static let verticalOffset = 15
        static let horizontalInset = -borderWidth
        static let height = 60
        static let textColor = Theme.textColor
        static let borderWidth: CGFloat = 2
        static let backgroundColor = Theme.itemsBackgroundColor
        static var borderColor: CGColor { Theme.borderCgColor }
        
        enum Prefix {
            static let open = "Жители\t▽"
            static let close = "Жители\t△"
        }
    }
    
    enum CollectionView {
        static let verticalInset = 15
        static let backgroundColor = Theme.itemsBackgroundColor
    }
}

final class LocationDetailsView: UIView {
    var cellTapHandler: ((Int) -> Void)?
    var residentsButtonTapHandler: (() -> Void)?
    private let nameLabel: UILabel
    private let typeLabel: UILabel
    private let dimensionLabel: UILabel
    private var residentsCountLabel: UILabel
    private var residentsButton: UIButton?
    private var charactersView: CharactersView?
    private var activityView: ActivityView?
    private var charactersViewBottomConstraint: Constraint?
    
    init() {
        self.nameLabel = UILabel()
        self.typeLabel = UILabel()
        self.dimensionLabel = UILabel()
        self.residentsCountLabel = UILabel()
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard let residentsButton = self.residentsButton else { return }
        residentsButton.layer.borderColor = Metrics.Button.borderColor
    }
    
    func update(with location: LocationDetails) {
        self.nameLabel.text = Metrics.Label.Prefix.name + location.name
        self.typeLabel.text = Metrics.Label.Prefix.type + location.type
        self.dimensionLabel.text = Metrics.Label.Prefix.dimension + location.dimension
        self.residentsCountLabel.text = Metrics.Label.Prefix.residentsCount + "\(location.residents.count)"
        if location.residents.count != 0 {
            configureResidentsButton()
            configureCharactersCollectionView()
        }
        self.activityView?.stopAnimating()
    }
    
    func update(with characters: [Character]) {
        guard let charactersView = self.charactersView else { return }
        charactersView.update(with: characters)
    }
    
    func update(with images: [String: UIImage?]) {
        guard let charactersView = self.charactersView else { return }
        charactersView.update(with: images)
    }
}

private extension LocationDetailsView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configure(label: self.nameLabel)
        configure(label: self.typeLabel, under: self.nameLabel)
        configure(label: self.dimensionLabel, under: self.typeLabel)
        configure(label: self.residentsCountLabel, under: self.dimensionLabel)
        self.activityView = ActivityView(superview: self)
        self.activityView?.startAnimating()
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
        label.font = Metrics.font
    }
    
    func configureTypeLabel() {
        self.addSubview(self.typeLabel)
    }
    
    func configureResidentsButton() {
        let residentsButton = UIButton(type: .system)
        self.addSubview(residentsButton)
        residentsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metrics.Button.horizontalInset)
            make.top.equalTo(self.residentsCountLabel.snp.bottom).offset(Metrics.Button.verticalOffset)
            make.height.equalTo(Metrics.Button.height)
        }
        residentsButton.layer.borderColor = Metrics.Button.borderColor
        residentsButton.layer.borderWidth = Metrics.Button.borderWidth
        residentsButton.setTitleColor(Metrics.Button.textColor, for: .normal)
        residentsButton.backgroundColor = Metrics.Button.backgroundColor
        residentsButton.titleLabel?.font = Metrics.font
        residentsButton.setTitle(Metrics.Button.Prefix.open, for: .normal)
        residentsButton.addTarget(self, action: #selector(residentsButtonTapped(_:)), for: .touchUpInside)
        self.residentsButton = residentsButton
    }
    
    func configureCharactersCollectionView() {
        let charactersView = CharactersView()
        guard let residentsButton = self.residentsButton else { return }
        self.addSubview(charactersView)
        charactersView.snp.makeConstraints { make in
            make.top.equalTo(residentsButton.snp.bottom)
            make.trailing.leading.equalToSuperview()
            self.charactersViewBottomConstraint = make.bottom.equalTo(residentsButton.snp.bottom).constraint
        }
        self.charactersView = charactersView
        self.layoutIfNeeded()
        self.charactersView?.configureLayout(with: self.frame.height - residentsButton.frame.maxY)
        self.charactersView?.cellTapHandler = { [weak self] characterId in
            self?.cellTapHandler?(characterId)
        }
    }
}

private extension LocationDetailsView {
    @objc func residentsButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: Metrics.animationDuration) {
            guard let charactersView = self.charactersView,
                  let residentsButton = self.residentsButton else { return }
            self.charactersViewBottomConstraint?.deactivate()
            charactersView.snp.makeConstraints { make in
                if charactersView.frame.height == 0 {
                    self.charactersViewBottomConstraint = make.bottom.equalToSuperview().constraint
                } else {
                    self.charactersViewBottomConstraint = make.bottom.equalTo(residentsButton.snp.bottom).constraint
                }
            }
            if charactersView.frame.height == 0 {
                residentsButton.setTitle(Metrics.Button.Prefix.close, for: .normal)
            } else {
                residentsButton.setTitle(Metrics.Button.Prefix.open, for: .normal)
            }
            self.layoutIfNeeded()
            self.charactersView?.showActivityIndicator()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.residentsButtonTapHandler?()
        })

    }
}
