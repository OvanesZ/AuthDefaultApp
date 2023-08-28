//
//  ProfileViewModel.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: UserModel
    
    init(profile: UserModel) {
        self.profile = profile
    }
    
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
            case .success(let user):
                print(user.name)
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
