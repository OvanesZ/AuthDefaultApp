//
//  FriendHomeView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 29.08.2023.
//

import SwiftUI

struct FriendHomeView: View {
    
    @ObservedObject var viewModel: FriendHomeViewModel
    
    var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 20),
        GridItem(.fixed(150), spacing: 20)
    ]
    
    var body: some View {
        
            VStack {
                
                HeaderFriendCell(viewModel: viewModel)
                
                Divider()
                    .padding([.leading, .trailing], 25)
                
                Button {
                    viewModel.loadNewFriendInCollection(viewModel.friend)
                } label: {
                    Text("Подписаться")
                }
                .buttonStyle(.bordered)
            }
            
            Divider()
            
            ScrollView {
                LazyVGrid (
                    columns: columns,
                    alignment: .center,
                    spacing: 15,
                    pinnedViews: [.sectionFooters]
                ) {
                    Section() {
                        ForEach(viewModel.wishlist) { present in
                            FriendPresentsMainView(present: present, friendHomeViewModel: viewModel)
                        }
                    }
                }
            }
            .background(
                Image("bg_present")
                    .resizable()
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fill)
            )
            .navigationTitle(viewModel.friend.displayName)
    }
}
