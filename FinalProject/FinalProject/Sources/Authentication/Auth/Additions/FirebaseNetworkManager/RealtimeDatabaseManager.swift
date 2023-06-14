//
//  RealtimeDatabaseManager.swift
//  FinalProject
//
//  Created by 1okmon on 07.06.2023.
//

import Firebase

private enum Metrics {
    static let databaseUrl = "https://shift-b3cf6-default-rtdb.europe-west1.firebasedatabase.app"
    static let usersDirectory = "users"
}

final class RealtimeDatabaseManager {
    static let shared = RealtimeDatabaseManager()
    
    private init() {}
    
    func createNewUser(with id: String, email: String, completion: @escaping (AuthResult) -> Void) {
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(id)
        let userData = UserDataRequest.userData(email: email,
                                         name: "",
                                         favoriteLocations: [],
                                         favoriteCharacters: [])
        ref.setValue(userData) { error, _ in
            guard let error = error else { return }
            completion(ErrorParser().parse(error: error))
        }
    }
    
    func updateUserInfo() {
    }
    
    func updateFavoriteLocations(locationsIds: [Int]) {
        let userData = UserDataRequest.favoriteLocations(locationsIds: locationsIds)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.updateChildValues(userData.value)
    }
    
    func updateFavoriteCharacters(charactersIds: [Int]) {
        let userData = UserDataRequest.favoriteCharacters(charactersIds: charactersIds)
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.updateChildValues(userData.value)
    }
    
    func loadUserData(completion: ((UserDataResponse) -> Void)?) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let userData = try JSONDecoder().decode(UserDataResponse.self, from: jsonData)
                completion?(userData)
            } catch let error {
                print(error)
            }
        })
    }
}
