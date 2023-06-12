//
//  IAlertRepresentable.swift
//  FinalProject
//
//  Created by 1okmon on 09.06.2023.
//

import Foundation
protocol IAlertRepresentable {
    var title: String { get }
    var message: String { get }
    var buttonTitle: String { get }
}
