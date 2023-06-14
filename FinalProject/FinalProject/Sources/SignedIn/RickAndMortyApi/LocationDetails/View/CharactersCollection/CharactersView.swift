//
//  CharactersView.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.collectionViewBackgroundColor
    
    enum Layout {
        static let cellsPerCol = 2
        static let sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

class CharactersView: UIView {
    var cellTapHandler: ((Int) -> Void)?
    private let collectionView: UICollectionView
    private var characters: [Int: Character]
    private var activityView: ActivityView?
    private var charactersIndexPath: [Int: IndexPath]
    private var imagesUrls: [String: Int]
    private var images: [String: UIImage?]
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        self.charactersIndexPath = [:]
        self.characters = [:]
        self.imagesUrls = [:]
        self.images = [:]
        self.collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.className)
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout(with height: CGFloat) {
        let layout = RowFlowLayout(
            cellsPerCol: Metrics.Layout.cellsPerCol,
            heightOfCollectionView: height,
            sectionInset: Metrics.Layout.sectionInset)
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
    }
    
    func update(with characters: [Character]) {
        DispatchQueue.main.async {
            var charactersCopy = self.characters
            for character in characters {
                charactersCopy[character.id] = nil
                guard self.characters[character.id] == nil else { continue }
                self.characters.updateValue(character, forKey: character.id)
                let characterIndexPath = IndexPath(row: self.charactersIndexPath.keys.count, section: 0)
                self.charactersIndexPath.updateValue(characterIndexPath, forKey: character.id)
                self.collectionView.insertItems(at: [characterIndexPath])
                self.imagesUrls.updateValue(character.id, forKey: character.image)
            }
            for (characterId, character) in charactersCopy {
                self.imagesUrls[character.image] = nil
                self.images[character.image] = nil
                self.characters[characterId] = nil
                guard let indexPath = self.charactersIndexPath[characterId] else { continue }
                self.collectionView.deleteItems(at: [indexPath])
                self.charactersIndexPath[characterId] = nil
            }
        }
    }
    
    func update(with images: [String: UIImage?]) {
        DispatchQueue.main.async {
            images.forEach { (url, image) in
                guard self.images[url] == nil,
                      let image = image else { return }
                self.images.updateValue(image, forKey: url)
                guard let characterId = self.imagesUrls[url],
                      let indexPath = self.charactersIndexPath[characterId] else { return }
                self.collectionView.reloadItems(at: [indexPath])
            }
            self.activityView?.stopAnimating()
        }
    }
    
    func showActivityIndicator() {
        if self.characters.isEmpty {
            self.activityView?.startAnimating()
        }
    }
}

private extension CharactersView {
    func configure() {
        self.configureCollectionView()
        self.activityView = ActivityView(superview: self)
    }
    
    func configureCollectionView() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.collectionView.backgroundColor = Metrics.backgroundColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension CharactersView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let characterId = self.charactersIndexPath.first(where: { $1 == indexPath })?.key else { return }
        self.cellTapHandler?(characterId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let characterId = self.charactersIndexPath.first(where: { $1 == indexPath })?.key,
              let character =  self.characters[characterId],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.className, for: indexPath) as? CharactersCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.update(with: character)
        guard let image = self.images[character.image],
              let image = image else {
            return cell
        }
        cell.update(with: image)
        return cell
    }
}
