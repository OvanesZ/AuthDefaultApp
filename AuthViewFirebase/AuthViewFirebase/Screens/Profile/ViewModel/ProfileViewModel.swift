//
//  ProfileViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var profile: UserModel
    @Published var image = UIImage(named: "person")!

    
    init(profile: UserModel) {
        self.profile = profile
    }
    
    
    func setProfile() {
        
        guard let imageData = image.jpegData(compressionQuality: 0.15) else { return }
        
        DatabaseService.shared.setProfile(user: profile, image: imageData) { result in
            switch result {
            case .success(let user):
                print(user.displayName)
            case .failure(let error):
                print("Ошибка при отправке данных на сервер \(error.localizedDescription)")
            }
        }
    }
    
    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
