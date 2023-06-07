//
//  FirebaseDB.swift
//  FinalProject
//
//  Created by 1okmon on 25.05.2023.
//
import Firebase

final class FirebaseNetworkManager: IFirebaseNetworkManager {
    private var realtimeDatabaseManager = RealtimeDatabaseManager.shared
    
    func signIn(with email: String, _ password: String, completion: @escaping (AuthResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                guard let error = error else { return }
                completion(ErrorParser().parse(error: error))
                return
            }
            guard result.user.isEmailVerified else {
                completion(.emailNotVerified(user: result.user))
                try? Auth.auth().signOut()
                return
            }
            completion(.successSignIn)
            self.realtimeDatabaseManager.updateFavoriteCharacters(charactersIds: [1, 2])
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
            self?.realtimeDatabaseManager.createNewUser(with: result.user.uid, email: email, completion: completion)
            self?.realtimeDatabaseManager.updateFavoriteCharacters(charactersIds: [])
            self?.sendEmailConfirmation(to: result.user, completion: { result in
                try? Auth.auth().signOut()
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
