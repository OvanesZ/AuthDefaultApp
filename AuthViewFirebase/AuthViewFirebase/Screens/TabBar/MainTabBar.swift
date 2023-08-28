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
            HomeView(viewModel: HomeViewModel(present: PresentModel()))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("First")
                    }
                }
            
            SecondView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Second")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "", name: "", phone: 0000000000, address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Second")
                    }
                }
        }
        
        
    }
}


