//
//  FirebaseStorageManger.swift
//  FinalProject
//
//  Created by 1okmon on 13.06.2023.
//

import UIKit
import Firebase
import FirebaseStorage

private enum Metrics {
    static let userPhotoPath = "UsersPhotos"}

final class FirebaseStorageManger {
    func uploadImage(_ image: UIImage, completion: ((URL?, Error?) -> Void)?) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference().child(Metrics.userPhotoPath).child(userID)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData) { _, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    completion?(nil, error)
                    return
                }
                completion?(url, nil)
            }
        }
    }
    
    func loadImage(from urlString: String, completion: ((Data?, Error?) -> Void)?) {
        let ref = Storage.storage().reference(forURL: urlString)
        let tenMegabytes = Int64(10*1024*1024)
        ref.getData(maxSize: tenMegabytes) { data, error in
            completion?(data, error)
        }
    }
}
