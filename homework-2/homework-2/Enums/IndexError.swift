//
//  Errors.swift
//  homework-2
//
//  Created by 1okmon on 21.04.2023.
//

import Foundation

enum IndexError: Error {
    case indexOutOfBound
}

extension IndexError: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .indexOutOfBound:
            return NSLocalizedString("Index out of range", comment: String())
        }
    }
    
    func printError() {
        print(self.errorDescription)
    }
}
