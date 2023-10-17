//
//  PresentViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage

class PresentModelViewModel: ObservableObject {
    
    let present: PresentModel
    
    @Published var uiImage = UIImage(named: "logo_wishlist")!
    @Published var isHiddenReservButton: Bool
    
    init(present: PresentModel) {
        self.present = present
        self.isHiddenReservButton = present.isReserved
    }
    
    private let currentUser = Auth.auth().currentUser
    
    //MARK: -- Добавляю новый подарок в коллекцию "Wishlist"
    
//    func loadNewPresentInCollection (_ present: PresentModel) {
//        do {
//            try Firestore.firestore().collection("Users").document(AuthService.shared.currentUser!.uid).collection("Wishlist").document(present.name ?? "").setData(from: present)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
    func setPresent(newPresent: PresentModel) {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.75) else { return }
        
        DatabaseService.shared.setPresent(present: newPresent, image: imageData) { result in
            switch result {
            case .success(let present):
                print(present.name)
            case .failure(let error):
                print("Ошибка при отправке данных на сервер \(error.localizedDescription)")
            }
        }
    }
    
    func getPresentImage() {
        StorageService.shared.downloadPresentImage(id: present.id) { result in
            switch result {
            case .success(let data):
                if let img = UIImage(data: data) {
                    self.uiImage = img
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //MARK: -- Резерв подарка
    
    func reservingPresent(_ present: PresentModel, _ user: UserModel, _ ownerPresent: UserModel) {
        let docRef = Firestore.firestore().collection("Users").document(ownerPresent.id).collection("Wishlist").document(present.name)
        
        docRef.updateData([
            "presentFromUser.email": user.email,
            "presentFromUser.displayName": user.displayName,
            "presentFromUser.userImageURLText": user.userImageURLText,
            "isReserved": true
        ]) { error in
            if let error = error {
                print("Ошибка при обновлении документа \(error)")
            } else {
                print("Документ успешно обновлены")
            }
        }
    }
    
    // MARK: -- Загружаю фото в Storage в дирректорию UserAvatarImage с названием фото email пользователя
    
    func loadImage(inputImage: UIImage) {
        
        let uploadRef = Storage.storage().reference(withPath: "PresentsImage/\(currentUser?.email ?? "")/\(UUID()).jpg")
        guard let imageData = inputImage.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
            if let error = error {
                print("Возникла ошибка: \(error.localizedDescription)")
                return
            }
            print("Загрузка выполнена успешно: \(String(describing: downloadMetadata))")
        }
    }
    
    
    // MARK: -- Получаю url загруженной фотографии пользователя
    
    func fetchURLImage() {
        let storageRef = Storage.storage().reference(withPath: "PresentsImage/\(currentUser?.email ?? "")/\(UUID()).jpg")
        
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Ошибка при получении URL адреса: \(error.localizedDescription)")
            } else {
                print(url ?? "")
                self.updatePresentUrlPhoto(url?.description ?? "")
            }
        }
    }
    
    // MARK: -- Обновляю свойство presentImageURLText документа подарка коллекции "Wishlist"
    
    func updatePresentUrlPhoto(_ urlString: String) {
        
        let docRef = Firestore.firestore().collection("User").document(currentUser?.email ?? "").collection("Wishlist").document(present.name)
        
        docRef.updateData([
            "presentImageURLText": urlString
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    
    
    // MARK: -- Загружаю фото в Storage в дирректорию PresentsImage с названием фото подарка
    
    func loadImagePresent(inputImage: UIImage) {
        
        let uploadRef = Storage.storage().reference(withPath: "UserAvatarImage/\(Auth.auth().currentUser?.email ?? "").jpg")
        guard let imageData = inputImage.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
            if let error = error {
                print("Возникла ошибка: \(error.localizedDescription)")
                return
            }
            print("Загрузка выполнена успешно: \(String(describing: downloadMetadata))")
        }
        
        uploadRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                // Uh-oh, an error occurred!
                return
            }
            self.updateUserPresentPhoto(url?.description ?? "")
        }
    }
    
    func updateUserPresentPhoto(_ urlString: String) {
        
        let docRef = Firestore.firestore().collection("User").document(Auth.auth().currentUser?.email ?? "")
        
        docRef.updateData([
            "userImageURLText": urlString
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    // MARK: -- Удаляю подарок из коллекции "Wishlist"
    
    func removingPresentFromWishlist(_ idPresent: String) {
        let docRef = Firestore.firestore().collection("Users").document(AuthService.shared.currentUser!.uid).collection("Wishlist").document(idPresent)
        
        docRef.delete() { error in
            if let error = error {
                print(error)
            } else {
                print("Подарок удален успешно")
            }
        }
    }
    
    
    
    
}
