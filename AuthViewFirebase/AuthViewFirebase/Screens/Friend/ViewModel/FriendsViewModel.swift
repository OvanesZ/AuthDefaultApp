//
//  FriendsViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 29.08.2023.
//

import Combine
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage



final class FriendsViewModel: ObservableObject {
    
    @Published var allUsers: [UserModel] = []
    @Published var myFriends: [UserModel] = []
    @Published var allFriendsUser: [UserModel] = []
    
    var myFriendsID: [String] = [" "]
    
    var currentUser = Auth.auth().currentUser
    let friend: UserModel
    
 
    init(friend: UserModel) {
        self.friend = friend
        
        fetchUsers()
        getFriends()
    }
    
    
    // MARK: -- Прослушиватель всех пользователей
    
 
    func fetchUsers() {
        Firestore.firestore().collection("Users").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.allUsers = snapshot?.documents.compactMap {
                try? $0.data(as: UserModel.self)
            } ?? []
        }
    }
    
    // MARK: -- Удаляю друга из коллекции "Friends"
    
    func removingFriendFromFriends(_ email: String) {
        let docRef = Firestore.firestore().collection("User").document(currentUser?.email ?? "").collection("Friends").document(email)
        
        docRef.delete() { error in
            if let error = error {
                print(error)
            } else {
                print("Пользователь удален успешно")
            }
        }
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
    
    
    
    // MARK: -- Прослушиваю авторизованного пользователя и кладу id друзей в массив myFriendsID и затем по фильтру in: myFriendsID прослушиваю изменения у друзей

    func getFriends() {
        
        let docRef = Firestore.firestore().collection("Users").document(AuthService.shared.currentUser!.uid)

        
        docRef.addSnapshotListener { snapshot, error in
            guard let document = snapshot else {
                print("Ошибка при получении id друзей \(error!)")
                return
            }

            guard let data = document.data() else {
                print("Документ пустой")
                return
            }

            guard let id = data["friendsID"] as? [String] else { return }
            self.myFriendsID = id
        }
        
        Firestore.firestore().collection("Users").whereField("id", in: myFriendsID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                self.myFriends = querySnapshot?.documents.compactMap {
                    try? $0.data(as: UserModel.self)
                } ?? []
                
            }
        }
        
        
    }
    
    
    
}



