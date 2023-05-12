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

extension IndexError {
    private var errorDescription: String {
        switch self {
        case .indexOutOfBound:
            return "Index out of range"
        }
    }
    
    func printError() {
        print(self.errorDescription)
    }
}
