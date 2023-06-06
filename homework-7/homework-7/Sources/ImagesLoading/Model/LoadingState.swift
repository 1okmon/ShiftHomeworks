//
//  CellState.swift
//  homework7
//
//  Created by 1okmon on 27.05.2023.
//

import UIKit

enum LoadingState: Equatable {
    case loaded(image: UIImage)
    case loading(progress: Float)
    case paused(progress: Float)
    case error
}
