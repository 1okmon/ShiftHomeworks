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
