//
//  FriendPresentMainView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 03.09.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


struct FriendPresentsMainView: View {
    
    let present: PresentModel
    @State var isShowPresentCell = false
    @ObservedObject var friendHomeViewModel: FriendHomeViewModel
    
    init(present: PresentModel, friendHomeViewModel: FriendHomeViewModel) {
        self.present = present
        self.friendHomeViewModel = friendHomeViewModel
    }
    
    var body: some View {
        

        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(present.isReserved ? LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 135, height: 135)
            .overlay {
                ZStack {
                    VStack {
                        
                        Button {
                            isShowPresentCell.toggle()
                        } label: {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .overlay {
                                    Image("present 1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        
                                }
                                .opacity(50)
                                .frame(width: 130, height: 130)
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .overlay(alignment: .bottomLeading) {
                                    Text(present.name ?? "").foregroundColor(.white)
                                        .padding(.leading, 15)
                                        .padding(.bottom, 10)
                                }
                        }
                    }
                }
                .sheet(isPresented: $isShowPresentCell) {
                    
                }
            }
    }
}
