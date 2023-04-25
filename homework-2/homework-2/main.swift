//
//  main.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

let threadSafeArrayOfClasses = ThreadSafeArray<TestClassToCheckEquality>()
let threadSafeArrayOfInts = ThreadSafeArray<Int>()
var arrayOfInt = [Int]()
var arrayOfIntX100 = [Int]()
for i in 0 ..< 100 {
    arrayOfInt.append(i)
    arrayOfIntX100.append(i*100)
}

//MARK: 2 async tasks
print("2 async tasks test")
let group = DispatchGroup()
group.enter()
DispatchQueue.global().async {
    threadSafeArrayOfInts.append(array: arrayOfIntX100)
    group.leave()
}
group.enter()
DispatchQueue.global().async {
    threadSafeArrayOfInts.append(array: arrayOfInt)
    group.leave()
}
group.wait()
for i in 0 ..< threadSafeArrayOfInts.count {
    print(threadSafeArrayOfInts.element(at: i))
}
print(threadSafeArrayOfInts.count)

//MARK: test equatable
print("\ntest equatable")
let a = TestClassToCheckEquality()
let b = a
let c = TestClassToCheckEquality()
threadSafeArrayOfClasses.append(a)
print(threadSafeArrayOfClasses.contains(a))
print(threadSafeArrayOfClasses.contains(b))
print(threadSafeArrayOfClasses.contains(c))
print(threadSafeArrayOfInts.contains(4))


//MARK: test index error
print("\ntest index error")
threadSafeArrayOfInts.remove(at: -1)
threadSafeArrayOfInts.remove(at: 0)
threadSafeArrayOfInts.remove(at: threadSafeArrayOfInts.count)

threadSafeArrayOfClasses.remove(at: -1)
threadSafeArrayOfClasses.remove(at: 0)
threadSafeArrayOfClasses.remove(at: threadSafeArrayOfInts.count)
