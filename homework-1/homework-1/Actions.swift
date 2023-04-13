//
//  Actions.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

class Actions {
    
    static func start() {
        Data.generateFakeCars()
        print(InterfaceMessage.hello.representedValue)
        while (true) {
            let id = Actions.askForAction(output: InterfaceMessage.userActions.representedValue ,upperBound: UserAction.allCases.count)
            if let id = id {
                UserAction.callAction(id: id)
            }
        }
    }
    
    static func askForAction(output: String, upperBound: Int) -> Int? {
        var answer = ""
        repeat {
            print(output)
            answer = readLine() ?? ""
        } while !isAnswerIsCorrect(input: answer, upperBound: upperBound)
        guard let id = Int(answer) else {
            return nil
        }
        return id - 1
    }
    
    private static func isAnswerIsCorrect(input: String, upperBound: Int) -> Bool {
        let answer = Int(input)
        guard let answer = answer, answer <= upperBound && answer > 0 else {
            print(InterfaceMessage.allert.representedValue)
            return false
        }
        return true
    }
    
    static func addNewCar() {
        var newCar = Car(manufacturer: "", model: "", body: .cabriolet, carNumber: "")
        newCar.manufacturer = inputManufacturer()
        newCar.model = inputModel()
        if let body = inputBody() {
            newCar.body = body
        }
        if let yearOfIssue = inputYearOfIssue() {
            newCar.yearOfIssue = yearOfIssue
        }
        newCar.carNumber = inputCarNumber()
        Data.cars.append(newCar)
    }
    
    private static func inputManufacturer() -> String {
        var userInput = ""
        while userInput.count <= 0 {
            print(NewCar.manufacturer.rawValue)
            userInput = readLine() ?? ""
            if userInput == "" {
                print(NewCar.manufacturer.wrongInput)
            }
        }
        return userInput
    }
    
    private static func inputModel() -> String {
        var userInput = ""
        while userInput.count <= 0 {
            print(NewCar.model.rawValue)
            userInput = readLine() ?? ""
            if userInput == "" {
                print(NewCar.model.wrongInput)
            }
        }
        return userInput
    }
    
    private static func inputBody() -> CarBodyType? {
        print(NewCar.body.rawValue)
        let bodyId = Actions.askForAction(output: InterfaceMessage.carBodies.representedValue, upperBound: CarBodyType.allCases.count)
        guard let bodyId = bodyId, let body = CarBodyType(rawValue: bodyId) else {
            return nil
        }
        return body
    }
    
    private static func inputYearOfIssue() -> Int? {
        var userInput = ""
        let yearWhenFirstAutoWasCreated = 1768
        repeat {
            print(NewCar.yearOfIssue.rawValue)
            userInput = readLine() ?? ""
            if userInput != "" && Int(userInput) == nil {
                print(NewCar.yearOfIssue.wrongInput)
            }
            if let year = Int(userInput){
                if year < yearWhenFirstAutoWasCreated || year > Calendar.current.component(.year, from: Date()) {
                    print(NewCar.yearOfIssue.wrongInput)
                    userInput = " "
                }
            }
        } while Int(userInput) == nil && userInput.count > 0
        return Int(userInput)
    }
    
    private static func inputCarNumber() -> String {
        print(NewCar.carNumber.rawValue)
        return readLine() ?? ""
    }
    
    static func printAllCars() {
        let cars = Data.cars
        guard !cars.isEmpty else {
            print(CarsNotFound.noCarAtAll.rawValue)
            return
        }
        for car in cars {
            car.printCar()
        }
    }
    
    static func printCarsByBody(bodyType: CarBodyType) {
        let cars = Data.cars
        var founded = false
        for car in cars {
            if car.body == bodyType {
                car.printCar()
                founded = true
            }
        }
        if !founded {
            print(CarsNotFound.noCarWithBodyFilter.rawValue)
        }
    }
}
