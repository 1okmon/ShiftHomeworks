//
//  ICharacterNetworkManager.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit

protocol ICharacterNetworkManagerCharacterDetails {
    func loadCharacter<T: ICharacter>(with id: Int, completion: ((T?, IAlertRepresentable?) -> Void)?)
    func loadImage(from urlString: String, completion: ((UIImage?, String?, IAlertRepresentable?) -> Void)?)
}

protocol ICharacterNetworkManagerLocationsDetails {
    func loadImage(from urlString: String, completion: ((UIImage?, String?, IAlertRepresentable?) -> Void)?)
    func loadCharacter<T: ICharacter>(by urlString: String, completion: ((T?, IAlertRepresentable?) -> Void)?)
}
