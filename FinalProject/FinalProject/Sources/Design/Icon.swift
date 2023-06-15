//
//  Icon.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

import UIKit

enum Icon {
    enum Favorite {
        private static let added = UIImage(systemName: "star.fill")
        private static let notAdded = UIImage(systemName: "star")
        
        static func image(_ isFavorite: Bool = false) -> UIImage? {
            if isFavorite {
                return self.added
            }
            return self.notAdded
        }
    }
}
