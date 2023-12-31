//
//  PresentView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import SwiftUI
import Kingfisher

struct PresentModalView: View {
    
    let currentPresent: PresentModel
    @ObservedObject var presentModelViewModel: PresentModelViewModel
    let nameTextUrl: String = "[Ссылка на подарок]"
    
    init(currentPresent: PresentModel, presentModelViewModel: PresentModelViewModel) {
        self.currentPresent = currentPresent
        self.presentModelViewModel = presentModelViewModel
    }
    
    var body: some View {
        
        VStack {
            Rectangle()
                .frame(minHeight: 250, idealHeight: 275, maxHeight: 300)
                .overlay {
                    Image("present 1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                }
            
            HStack {
                Text("Описание")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 15)
                    .padding(.top, 25)
                Spacer()
            }
            
            // https://fonts-online.ru/fonts/volja/download Скачать новые шрифты
            
            
            HStack {
                Text(presentModelViewModel.present.presentDescription)
                    .frame(minHeight: 25, idealHeight: 25, maxHeight: 50)
                
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .padding(.trailing, 5)
                    .padding(.top, 5)
                    .font(.custom("SF-Pro-Display-Regular", fixedSize: 14))
                
                Spacer()
            }
            
            Divider()
                .padding()
            
            HStack {
                Text(.init(nameTextUrl+"(\(presentModelViewModel.present.urlText))"))
                    .underline()
                    .padding(.leading, 15)
                Spacer()
            }
            
            Divider()
                .padding()
            Spacer()
            
            
            // MARK: -- Статус подарка
            
            VStack {
                HStack {
                    if presentModelViewModel.isHiddenReservButton {
                        Text("Подарит")
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
                
                HStack {
                    if presentModelViewModel.isHiddenReservButton {
                        
                        KFImage(presentModelViewModel.present.presentFromUser.userImage)
                            .resizable()
                        //                                .padding(.leading, 15)
                            .frame(width: 70, height: 70)
                            .modifier(CircleShadow(shadowColor: .white, shadowRadius: 0))
                        
                        Text(presentModelViewModel.present.presentFromUser.displayName)
                            .font(.title2)
                        //                                .bold()
                            .foregroundColor(.white)
                            .opacity(15)
                            .padding(.leading, 15)
                    } else {
                        
                    }
                    Spacer()
                }
                .padding(.leading, 15)
                
                
            }
            
            Divider()
                .padding()
            
            // MARK: -- Кнопки удалить
            
            Button(action: {
                presentModelViewModel.removingPresentFromWishlist(currentPresent.name ?? "")
            }) {
                Image(systemName: "trash")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
        
    }
}

