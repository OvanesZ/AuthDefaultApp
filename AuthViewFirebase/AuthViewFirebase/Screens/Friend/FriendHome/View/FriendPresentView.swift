//
//  FriendPresentView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 03.09.2023.
//

import SwiftUI

struct FriendPresentView: View {
    
    
    let currentPresent: PresentModel
    @ObservedObject var viewModel: PresentModelViewModel
    @ObservedObject var userViewModel: HomeViewModel
    @ObservedObject var friendHomeViewModel: FriendHomeViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    init(currentPresent: PresentModel, viewModel: PresentModelViewModel, userViewModel: HomeViewModel, friendHomeViewModel: FriendHomeViewModel, profileViewModel: ProfileViewModel) {
        self.currentPresent = currentPresent
        self.viewModel = viewModel
        self.userViewModel = userViewModel
        self.friendHomeViewModel = friendHomeViewModel
        self.profileViewModel = profileViewModel
    }
    
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "PhotoPlace4")!)
                .resizable()
                .frame(width: 200, height: 200)
                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .padding(.top, 10)
            
            Spacer()
            
            HStack {
                Text("Описание:")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 15)
                Spacer()
            }
            
            // https://fonts-online.ru/fonts/volja/download Скачать новые шрифты
          
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading))
                .frame(width: 360, height: 150)
                .frame(maxWidth: 500)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .overlay {
                    Text(viewModel.present.presentDescription)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .padding(.top, 5)
                        .font(.custom("SF-Pro-Display-Regular", fixedSize: 14))
                }
            
            HStack {
                Text("Ссылка на товар:")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .opacity(15)
                    .padding(.leading, 15)
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading))
                .frame(width: 360, height: 80)
                .frame(maxWidth: 500)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .overlay {
                    Link("Тапни для перехода к подарку в интернет-магазин",
                         destination: URL(string: viewModel.present.urlText)!)
                        .frame(width: 340, height: 60)
                        .font(.custom("SF-Pro-Display-Regular", fixedSize: 14))
                        .lineLimit(3)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .padding(.top, 5)
                    
                }
            
            HStack {
                
                if viewModel.isHiddenReservButton {
                    Text("Подарит \(viewModel.present.presentFromUser.displayName)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(15)
                        .padding(.leading, 15)
                } else {
                    Text("Подарок свободен")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(15)
                        .padding(.leading, 15)
                }
                
                Spacer()
            }
            
            
            Spacer()
            Spacer()
            
            
            HStack {
                
                if viewModel.isHiddenReservButton {
                    Text("Подарок зарезервирован")
                } else {
                    Button(action: {
                        viewModel.reservingPresent(currentPresent, profileViewModel.profile, friendHomeViewModel.friend)
                        dismiss()
                    }) {
                        Text("Выбрать подарок")
                            .font(.headline)
                            .frame(maxWidth: 200)
                            .frame(height: 35)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .padding(.bottom, 30)
                            .padding(.leading, 6)
                            .padding(.trailing, 6)
                    }
                }
                
            }
        }
        .background(viewModel.isHiddenReservButton ? LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

