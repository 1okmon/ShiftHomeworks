//
//  UserData.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import UIKit

struct UserData {
    var firstName: String
    var lastName: String
    var image: UIImage?
    
    init(firstName: String?, lastName: String?, image: UIImage? = nil) {
        self.firstName = firstName ?? String()
        self.lastName = lastName ?? String()
        self.image = image
    }
    
    init(userDataResponse: UserDataResponse, image: UIImage? = nil) {
        self.firstName = userDataResponse.firstName ?? String()
        self.lastName = userDataResponse.lastName ?? String()
        self.image = image
    }
}
