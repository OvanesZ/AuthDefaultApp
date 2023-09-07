//
//  MainTabBar.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    
    
    var body: some View {
        
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.3.group")
                        Text("Главная")
                    }
                }
            
            FriendsView(friendViewModel: FriendsViewModel(friend: UserModel(id: "", email: "", displayName: "", phoneNumber: 0, address: "", dateOfBirth: Date())), userViewModel: HomeViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "person.3.sequence")
                        Text("Друзья")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "", email: "", displayName: "", phoneNumber: 0, address: "", dateOfBirth: Date())))
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Профиль")
                    }
                }
        }
        
        
    }
}


