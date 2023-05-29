//
//  Observing.swift
//  homework7
//
//  Created by 1okmon on 28.05.2023.
//

import Foundation

protocol IObserver: AnyObject {
    var id: UUID { get }
    func update<T>(with value: T)
}

protocol IObservable: AnyObject {
    associatedtype T
    var value: T { get set }
    var observers: [IObserver] { get }
    
    func subscribe(observer: IObserver)
    func unsubscribe(observer: IObserver)
}

final class Observable<T>: IObservable {
    var value: T {
        didSet {
            self.notify(newValue: self.value)
        }
    }
    var observers = [IObserver]()
    
    init(value: T) {
        self.value = value
    }
    
    func subscribe(observer: IObserver) {
        self.observers.append(observer)
    }
    
    func unsubscribe(observer: IObserver) {
        self.observers = self.observers.filter { $0.id != observer.id }
    }
    
    func notify<T>(newValue: T) {
        observers.forEach { observer in
            observer.update(with: newValue)
        }
    }
}
