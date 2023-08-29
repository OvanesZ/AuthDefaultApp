//
//  AuthService.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    private init() { }
    private let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { result, error in
            
            if let result = result {
                let userModel = UserModel(id: result.user.uid, email: result.user.email ?? "", displayName: "", phoneNumber: 0, address: "")
                DatabaseService.shared.setProfile(user: userModel) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    
    
}
