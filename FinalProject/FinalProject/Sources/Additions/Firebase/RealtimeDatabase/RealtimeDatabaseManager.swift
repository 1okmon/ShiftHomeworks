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

final class RealtimeDatabaseManager: INewUserRealtimeDatabaseManager, IUserDataRealtimeDatabaseManager {
    static let shared = RealtimeDatabaseManager()
    
    private init() {}
    
    func createNewUser(with id: String, email: String, completion: @escaping (IAlertRepresentable) -> Void) {
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(id)
        let value = UserDataRequestBuilder().setEmail(email).build()
        ref.setValue(value) { error, _ in
            guard let error = error else { return }
            completion(AuthResponseParser().parse(error: error))
        }
    }
    
    func updateUserData(to userData: UserData) {
        let value = UserDataRequestBuilder().setFirstName(userData.firstName).setLastName(userData.lastName).build()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.updateChildValues(value)
    }
    
    func updateFavoriteLocations(locationsIds: [Int]) {
        let value = UserDataRequestBuilder().setFavoriteLocations(locationsIds).build()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.updateChildValues(value)
    }
    
    func updateFavoriteCharacters(charactersIds: [Int]) {
        let value = UserDataRequestBuilder().setFavoriteCharacters(charactersIds).build()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(userID)
        ref.updateChildValues(value)
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
