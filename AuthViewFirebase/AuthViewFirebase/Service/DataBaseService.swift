//
//  DataBaseService.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("Users")
    }
    private init() { }
    
    
    func setProfile(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        usersRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else { return }
            
            guard let data = snap.data() else { return }
            
            guard let id = data["id"] as? String else { return }
            guard let email = data["email"] as? String else { return }
            guard let displayName = data["displayName"] as? String else { return }
            guard let phoneNumber = data["phoneNumber"] as? Int else { return }
            guard let address = data["address"] as? String else { return }
            
            let user = UserModel(id: id, email: email, displayName: displayName, phoneNumber: phoneNumber, address: address)
            
            completion(.success(user))
        }
    }
    
}

