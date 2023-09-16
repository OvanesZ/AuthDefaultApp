//
//  StorageService.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 17.09.2023.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    private init() { }
    
    // MARK: - private let
    private let storage = Storage.storage().reference()
    
    // MARK: - private var
    private var userImageRef: StorageReference {
        storage.child("userImage")
    }
    
    private var presentImageRef: StorageReference {
        storage.child("presentImage")
    }
    
    // MARK: - func
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> ()) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        userImageRef.child(id).putData(image, metadata: metadata) { metadata, error in
            
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения \(metadata.size)"))
        }
    }
    
    
    
}
