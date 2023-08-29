//
//  PresentModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PresentModel: Codable, Identifiable {
    
    @DocumentID var id: String?
    var name: String? = ""
    var havePhoto: Bool = false
    var urlText = ""
    
    var presentFromUser: UserModel = UserModel(id: "", email: "", displayName: "", phoneNumber: 0, address: "")

    var isReserved = false
    
    var presentImageURLText = ""
    var presentImage: URL? { URL(string: "\(presentImageURLText)")}
    var presentDescription = ""
    
 
}
