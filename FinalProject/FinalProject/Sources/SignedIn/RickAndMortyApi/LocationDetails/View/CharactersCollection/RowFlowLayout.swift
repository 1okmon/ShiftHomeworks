//
//  RowFlowLayout.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

private enum Metrics {
    static let maxWidth = UIScreen.main.bounds.width - 70
}

 final class RowFlowLayout: UICollectionViewFlowLayout {
     private let cellsPerCol: Int
     private let heightOfCollectionView: CGFloat

     init(cellsPerCol: Int, heightOfCollectionView: CGFloat, sectionInset: UIEdgeInsets = .zero) {
         self.cellsPerCol = cellsPerCol
         self.heightOfCollectionView = heightOfCollectionView
         super.init()
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
                                 minimumLineSpacing * CGFloat(cellsPerCol)
         var itemHeight = ((heightOfCollectionView - marginsAndInsets) /
                          CGFloat(cellsPerCol)).rounded(.down)
         itemHeight = itemHeight > Metrics.maxWidth ? Metrics.maxWidth : itemHeight
         itemSize = CGSize(width: itemHeight, height: itemHeight)
     }
 }
