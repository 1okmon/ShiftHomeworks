//
//  MultiThreadArray.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

final class MultiThreadArray: ArrayMetods, ArrayProperties {
    private var arrayOfAny: [Any] = []
    private var semaphore = DispatchSemaphore(value: 1)
    var isEmpty: Bool {
        get {
            return arrayOfAny.isEmpty
        }
    }
    var count: Int {
        get {
            return arrayOfAny.count
        }
    }
    
    private func safeActionWithSemaphore (action: () -> (Any)) -> Any {
        semaphore.wait()
        let result = action()
        semaphore.signal()
        return result
    }
    
    func append(_ item: Any) {
        _ = safeActionWithSemaphore {
            arrayOfAny.append(item)
        }
    }
    
    func remove(at index: Int) {
        _ = safeActionWithSemaphore {
            arrayOfAny.remove(at: index)
        }
    }
    
    func element(at index: Int) -> Any {
        safeActionWithSemaphore {
            return arrayOfAny[index]
        }
    }
    
    private func equals(_ x : Any, _ y : Any) -> Bool {
        if let x = x as? any AbleToCheckEquality, let y = y as? any AbleToCheckEquality {
            return x.equals(to: y)
        }
        guard let x = x as? AnyHashable, let y = y as? AnyHashable else {
            return false
        }
        return x == y
    }
    
    func contains(_ element: Any) -> Bool {
        safeActionWithSemaphore {
            return arrayOfAny.contains(where: { equals($0, element) })
        } as? Bool ?? false
    }
    
    func append(array: [Any]) {
        array.forEach { self.append($0) }
    }
}
