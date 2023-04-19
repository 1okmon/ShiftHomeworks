//
//  main.swift
//  homework-2
//
//  Created by 1okmon on 19.04.2023.
//

import Foundation

let multiThreadArray = MultiThreadArray()
var arrayOfInt = [Int]()
var arrayOfIntX100 = [Int]()
for i in 0 ..< 100 {
    arrayOfInt.append(i)
    arrayOfIntX100.append(i*100)
}

//MARK: 2 async tasks
let group = DispatchGroup()
group.enter()
DispatchQueue.global(qos: .default).async {
    multiThreadArray.append(array: arrayOfIntX100)
    group.leave()
}
group.enter()
DispatchQueue.global(qos: .default).async {
    multiThreadArray.append(array: arrayOfInt)
    group.leave()
}
group.wait()
print(multiThreadArray.count)

//MARK: test equatable
let a = TestClassToCheckEquality()
let b = a
let c = TestClassToCheckEquality()
multiThreadArray.append(a)
multiThreadArray.append(4)
multiThreadArray.append("string")
print(multiThreadArray.contains(a))
print(multiThreadArray.contains(b))
print(multiThreadArray.contains(c))
print(multiThreadArray.contains(4))
print(multiThreadArray.contains("string"))
print(multiThreadArray.count)
