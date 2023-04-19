//
//  Data.swift
//  homework-1
//
//  Created by 1okmon on 13.04.2023.
//

import Foundation

final class Data {
    static var cars : [Car] = [Car]()
    
    static func generateFakeCars() {
        cars.append(Car(manufacturer: "BMW", model: "M4", body: .coupe, carNumber: ""))
        cars.append(Car(manufacturer: "BMW", model: "M3", body: .sportsCar, carNumber: "112"))
        cars.append(Car(manufacturer: "BMW", model: "Z4", body: .sportsCar,yearOfIssue: 2018, carNumber: "112"))
    }
}
