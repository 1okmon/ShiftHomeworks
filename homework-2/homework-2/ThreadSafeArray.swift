//
//  MultiThreadArray.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

final class ThreadSafeArray<T: Equatable>: ArrayMethods, ArrayProperties {
    private var array: [T] = []
    private var semaphore = DispatchSemaphore(value: 1)
    var isEmpty: Bool {
        get {
            var result = false
            doInSemaphore { result = self.array.isEmpty }
            return result
        }
    }
    var count: Int {
        get {
            var result = 0
            doInSemaphore { result = self.array.count }
            return result
        }
    }
    
    func append(_ item: T) {
        doInSemaphore { self.array.append(item) }
    }
    
    func remove(at index: Int) {
        guard isExistElement(at: index) else {
            IndexError.indexOutOfBound.printError()
            return
        }
        doInSemaphore { self.array.remove(at: index) }
    }
    
    func element(at index: Int) -> T? {
        guard isExistElement(at: index) else {
            IndexError.indexOutOfBound.printError()
            return nil
        }
        var result: T?
        doInSemaphore { result = self.array[index] }
        return result
    }
    
    func contains(_ element: T) -> Bool {
        var result = false
        doInSemaphore {
            result = self.array.contains(where: { equals($0, element) })
        }
        return result
    }
    
    func append(array: [T]) {
        array.forEach{ append($0) }
    }
}

//MARK: private methods
private extension ThreadSafeArray {
    func doInSemaphore(action:() -> ()) {
        semaphore.wait()
        action()
        semaphore.signal()
    }
    
    func equals(_ x : T, _ y : T) -> Bool {
        return x == y
    }
    
    func isExistElement(at index: Int) -> Bool {
        !self.array.isEmpty && index >= 0 && index < self.array.count
    }
}
