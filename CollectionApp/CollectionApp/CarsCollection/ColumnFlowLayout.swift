//
//  ColumnFlowLayout.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

final class ColumnFlowLayout: UICollectionViewFlowLayout {
    private let cellsPerRow: Int

    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let marginsAndInsets =  sectionInset.left +
                                sectionInset.right +
                                collectionView.safeAreaInsets.left +
                                collectionView.safeAreaInsets.right +
                                minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) /
                         CGFloat(cellsPerRow)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
}
