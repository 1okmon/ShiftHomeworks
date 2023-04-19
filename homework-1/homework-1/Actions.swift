//
//  Actions.swift
//  homework-1
//
//  Created by 1okmon on 12.04.2023.
//

import Foundation

final class Actions {
    static let action = Actions()
    
    func start() {
        Data.generateFakeCars()
        print(InterfaceMessage.hello.representedValue)
        while true {
            let id = askForAction(output: InterfaceMessage.userActions.representedValue ,upperBound: UserAction.allCases.count)
            if let id = id {
                UserAction.callAction(id: id)
            }
        }
    }
    
    func askForAction(output: String, upperBound: Int) -> Int? {
        var answer = String()
        repeat {
            print(output)
            answer = readLine() ?? String()
        } while !isAnswerIsCorrect(input: answer, upperBound: upperBound)
        return Int(answer)
    }
    
    private func isAnswerIsCorrect(input: String, upperBound: Int) -> Bool {
        guard let answer = Int(input), answer <= upperBound && answer > 0 else {
            print(InterfaceMessage.allert.representedValue)
            return false
        }
        return true
    }
    
    func addNewCar() {
        let manufacturer = inputManufacturer()
        let model = inputModel()
        let body = inputBody()
        let yearOfIssue = inputYearOfIssue()
        let carNumber = inputCarNumber()
        guard let body = body else {
            return
        }
        Data.cars.append(Car(manufacturer: manufacturer,
                             model: model,
                             body: body,
                             yearOfIssue: yearOfIssue,
                             carNumber: carNumber))
    }
    
    private func inputManufacturer() -> String {
        var userInput = String()
        while userInput.isEmpty {
            print(NewCar.manufacturer.carPartEnterCommand)
            userInput = readLine() ?? String()
            if userInput.isEmpty {
                print(NewCar.manufacturer.wrongInput)
            }
        }
        return userInput
    }
    
    private func inputModel() -> String {
        var userInput = String()
        while userInput.isEmpty {
            print(NewCar.model.carPartEnterCommand)
            userInput = readLine() ?? String()
            if userInput.isEmpty {
                print(NewCar.model.wrongInput)
            }
        }
        return userInput
    }
    
    private func inputBody() -> CarBodyType? {
        print(NewCar.body.carPartEnterCommand)
        let bodyId = askForAction(output: InterfaceMessage.carBodies.representedValue, upperBound: CarBodyType.allCases.count)
        guard let bodyId = bodyId, let body = CarBodyType(rawValue: bodyId) else {
            return nil
        }
        return body
    }
    
    private func inputYearOfIssue() -> Int? {
        var userInput = String()
        let yearWhenFirstAutoWasCreated = 1768
        repeat {
            print(NewCar.yearOfIssue.carPartEnterCommand)
            userInput = readLine() ?? String()
            if !userInput.isEmpty && Int(userInput) == nil {
                print(NewCar.yearOfIssue.wrongInput)
            }
            if let year = Int(userInput) {
                if year < yearWhenFirstAutoWasCreated || year > Calendar.current.component(.year, from: Date()) {
                    print(NewCar.yearOfIssue.wrongInput)
                    userInput = " "
                }
            }
        } while Int(userInput) == nil && !userInput.isEmpty
        return Int(userInput)
    }
    
    private func inputCarNumber() -> String {
        print(NewCar.carNumber.carPartEnterCommand)
        return readLine() ?? String()
    }
    
    func printAllCars() {
        let cars = Data.cars
        guard !cars.isEmpty else {
            print(CarsNotFoundError.noCarAtAll.errorDescription ?? String())
            return
        }
        cars.forEach { $0.printCar() }
    }
    
    func printCarsByBody(bodyType: CarBodyType) {
        let cars = Data.cars.filter { $0.body == bodyType}
        cars.forEach { $0.printCar() }
        if cars.isEmpty {
            print(CarsNotFoundError.noCarWithBodyFilter.errorDescription ?? String())
        }
    }
}
