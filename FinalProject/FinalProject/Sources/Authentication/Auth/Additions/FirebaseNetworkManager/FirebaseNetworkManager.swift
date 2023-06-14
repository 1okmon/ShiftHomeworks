//
//  FirebaseDB.swift
//  FinalProject
//
//  Created by 1okmon on 25.05.2023.
//
import Firebase

private enum Metrics {
    static let databaseUrl = "https://shift-b3cf6-default-rtdb.europe-west1.firebasedatabase.app"
    static let usersDirectory = "users"
    
    struct UserData {
        enum UserFields: String {
            case email
            case name
        }
        
        var email: String
        var array: [String: Any] {
            var array = [String: Any]()
            array.updateValue(email, forKey: UserFields.email.rawValue)
            return(array)
        }
    }
}

final class FirebaseNetworkManager: IFirebaseNetworkManager {
    func signIn(with email: String, _ password: String, completion: @escaping (AuthResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
                return
            }
            guard result.user.isEmailVerified else {
                completion(.emailNotVerified(user: result.user))
                return
            }
            completion(.successSignIn)
        }
    }
    
    func submitSignUp(with email: String, _ password: String, completion: @escaping (AuthResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
                return
            }
            guard let result = result else { return }
            let ref = Database.database(url: Metrics.databaseUrl).reference().child(Metrics.usersDirectory).child(result.user.uid)
            ref.setValue(Metrics.UserData(email: email).array) { error, _ in
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
            }
            self?.sendEmailConfirmation(to: result.user, completion: { result in
                completion(result)
            })
        }
    }
    
    func submitResetPassword(with email: String, completion: @escaping (AuthResult) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
                return
            }
            completion(.resetPasswordLinkSent)
        }
    }
    
    func sendEmailConfirmation(to user: User, completion: @escaping (AuthResult) -> Void) {
        user.sendEmailVerification { error in
            guard error == nil else {
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
                return }
            completion(.emailVerificationSent)
        }
    }
}
