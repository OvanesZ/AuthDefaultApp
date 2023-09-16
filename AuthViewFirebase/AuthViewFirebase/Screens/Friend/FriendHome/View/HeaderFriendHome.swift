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
        
        
            HStack {
                
                Image(uiImage: viewModel.uiImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                
                
                VStack {
                    Text("Дата рождения:")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 25)
                        .padding(.horizontal, 20)
                    
                    Text("\(viewModel.friend.dateOfBirth.formatted(.dateTime.day().month().year().locale(Locale(identifier: "ru_RU"))))")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 25, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                }
            }
            .onAppear {
                viewModel.getImage()
            }
            .padding(.leading)
    }
}
