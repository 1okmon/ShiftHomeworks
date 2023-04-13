//
//  Car.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

struct Car {
    var manufacturer: String
    var model: String
    var body: CarBodyType
    var yearOfIssue: Int?
    var carNumber: String
    
    func printCar() {
        var info =  "<manufacturer>: <\(manufacturer)>\n" +
                    "<model>: <\(model)>\n" +
                    "<body>: <\(body)>\n"
        if let yearOfIssue = yearOfIssue {
            info = info + "<yearOfIssue>: <\(yearOfIssue)>\n"
        } else {
            info = info + "<yearOfIssue>: <->\n"
        }
        if carNumber != "" {
            info = info + "<carNumber>: <\(carNumber)>\n"
        }
        print(info)
    }
}
