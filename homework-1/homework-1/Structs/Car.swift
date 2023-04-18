//
//  Car.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

struct Car {
    let manufacturer: String
    let model: String
    let body: CarBodyType
    var yearOfIssue: Int?
    let carNumber: String
    
    func printCar() {
        var info =  "<manufacturer>: <\(manufacturer)>\n" +
                    "<model>: <\(model)>\n" +
                    "<body>: <\(body)>\n"
        if let yearOfIssue = yearOfIssue {
            info = info + "<yearOfIssue>: <\(yearOfIssue)>\n"
        } else {
            info = info + "<yearOfIssue>: <->\n"
        }
        if !carNumber.isEmpty {
            info = info + "<carNumber>: <\(carNumber)>\n"
        }
        print(info)
    }
}
