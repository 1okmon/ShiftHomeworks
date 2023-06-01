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

final class CharactersView: UIView {
    var cellTapHandler: ((Int) -> Void)?
    private let collectionView: UICollectionView
    private var characters: [Character]
    private var images: [String: UIImage?]
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout:
                .init())
        self.characters = []
        self.images = [:]
        self.collectionView.register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.className)
        super.init(frame: .zero)
        configure()
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
        self.characters = characters
        collectionView.reloadData()
    }
    
    func update(with images: [String: UIImage?]) {
        self.images = images
        collectionView.reloadData()
    }
}

private extension CharactersView {
    func configure() {
        configureCollectionView()
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
        guard (0 ..< characters.count).contains(indexPath.row) else { return }
        let characterId = self.characters[indexPath.row].id
        self.cellTapHandler?(characterId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.className, for: indexPath) as? CharactersCollectionViewCell else {
            return UICollectionViewCell()
        }
        let character = self.characters[indexPath.row]
        cell.update(with: character)
        guard let image = self.images[character.image],
              let image = image else {
            return cell
        }
        cell.update(with: image)
        return cell
    }
}
