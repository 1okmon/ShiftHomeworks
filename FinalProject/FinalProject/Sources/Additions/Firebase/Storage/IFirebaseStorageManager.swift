//
//  IFirebaseStorageManager.swift
//  FinalProject
//
//  Created by 1okmon on 14.06.2023.
//

import UIKit

protocol IFirebaseStorageManager {
    func uploadImage(_ image: UIImage, completion: ((URL?, Error?) -> Void)?)
    func loadImage(from urlString: String, completion: ((Data?, Error?) -> Void)?)
}
