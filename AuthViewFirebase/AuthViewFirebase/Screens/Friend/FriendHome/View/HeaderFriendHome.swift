//
//  HeaderFriendHome.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 03.09.2023.
//

import SwiftUI
import Kingfisher

struct HeaderFriendCell: View {
    
    @ObservedObject var viewModel: FriendHomeViewModel
    
    var body: some View {
        
        
        ZStack {
            HStack {
                
                KFImage(viewModel.friend.userImage)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.leading)
                    .modifier(CircleShadow(shadowColor: .white, shadowRadius: 1))
                
                VStack {
                    Text(viewModel.friend.displayName)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 25)
                        .padding(.horizontal, 20)
                    
                    Text("Возраст: 31")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 25, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    Text("12.06.1991")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 25)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.leading)
        }
    }
}