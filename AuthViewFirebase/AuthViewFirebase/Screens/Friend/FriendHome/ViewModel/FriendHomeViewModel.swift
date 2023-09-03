//
//  FriendHomeViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 03.09.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


class FriendHomeViewModel: ObservableObject {
    
    let friend: UserModel
    @Published var wishlist: [PresentModel] = []
    
    init(friend: UserModel) {
        self.friend = friend
        fetchWishlistFriend()
    }
    
    
    // MARK: -- (Добавление в друзья) Добавляю id друга в массив friendsID
   
    func loadNewFriendInCollection (_ friend: UserModel) {
        let docRef = Firestore.firestore().collection("Users").document(AuthService.shared.currentUser!.uid)
        
        docRef.updateData([
            "friendsID": FieldValue.arrayUnion([friend.id])
        ]) { err in
            if let err = err {
                print("Возникла ошибка при добавлении id пользователя в коллекцию Friends: \(err)")
            } else {
                print("id пользователя добавлен в коллекцию Friends")
            }
        }
    }
    
    // MARK: -- Прослушиватель коллекции wishlist друга
    
    func fetchWishlistFriend() {
        let docRef = Firestore.firestore().collection("Users").document(friend.id).collection("Wishlist")
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
    
    
}
