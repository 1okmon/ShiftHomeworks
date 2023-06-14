//
//  UserData.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import Foundation

struct UserData {
    var firstName: String
    var lastName: String
    
    init(firstName: String?, lastName: String?) {
        self.firstName = firstName ?? String()
        self.lastName = lastName ?? String()
    }
    
    init(userDataResponse: UserDataResponse) {
        self.firstName = userDataResponse.firstName ?? String()
        self.lastName = userDataResponse.lastName ?? String()
    }
}
