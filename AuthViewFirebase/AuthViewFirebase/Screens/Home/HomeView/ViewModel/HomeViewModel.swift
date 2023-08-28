//
//  HomeViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import Combine
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage

final class HomeViewModel: ObservableObject {
    
    let present: PresentModel
    @Published var users: [User] = []
    @Published var wishlist: [PresentModel] = [] // будет содержать все подарки пользователя
    var currentUser = Auth.auth().currentUser
    
    @Published var mockWishlist: [PresentModel] = [
        PresentModel(id: "1", name: "IPhone", havePhoto: true, urlText: "", isReserved: false, presentImageURLText: "https://ozon.ru", presentDescription: "Red. Pro Max. 512 Gb."),
        PresentModel(id: "2", name: "IPhone", havePhoto: true, urlText: "", isReserved: false, presentImageURLText: "https://ozon.ru", presentDescription: "Red. Pro Max. 512 Gb."),
        PresentModel(id: "3", name: "IPhone", havePhoto: true, urlText: "", isReserved: true, presentImageURLText: "https://ozon.ru", presentDescription: "Red. Pro Max. 512 Gb."),
        PresentModel(id: "4", name: "IPhone", havePhoto: true, urlText: "", isReserved: false, presentImageURLText: "https://ozon.ru", presentDescription: "Red. Pro Max. 512 Gb."),
        PresentModel(id: "5", name: "IPhone", havePhoto: true, urlText: "", isReserved: true, presentImageURLText: "https://ozon.ru", presentDescription: "Red. Pro Max. 512 Gb.")
    ]
    
    
    init(present: PresentModel) {
        self.present = present
        fetchWishlist()
    }
    
    
    
    
    

    // MARK: -- Прослушиватель обновлений коллекции Wishlist. (пишет все данные в переменную wishlist)
    
    func fetchWishlist() {
        let docRef = Firestore.firestore().collection("User").document(currentUser?.email ?? "").collection("Wishlist")
        docRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.wishlist = snapshot?.documents.compactMap {
                try? $0.data(as: PresentModel.self)
            } ?? []
        }
    }
    
    
    // MARK: -- Удаляю подарок из коллекции "Wishlist"
    
    func removingPresentFromWishlist(_ namePresent: String) {
        let docRef = Firestore.firestore().collection("User").document(currentUser?.email ?? "").collection("Wishlist").document(namePresent)
        
        docRef.delete() { error in
            if let error = error {
                print(error)
            } else {
                print("Подарок удален успешно")
            }
        }
    }
    

 
    
    
}
