//
//  PresentView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import SwiftUI

struct PresentModalView: View {
    
    let currentPresent: PresentModel
    @ObservedObject var presentModelViewModel: PresentModelViewModel
    let nameTextUrl: String = "[Ссылка на подарок]"
    
    init(currentPresent: PresentModel, presentModelViewModel: PresentModelViewModel) {
        self.currentPresent = currentPresent
        self.presentModelViewModel = presentModelViewModel
    }
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                Spacer()
                Text(presentModelViewModel.present.name)
                    .padding(.top, 40)
                    .font(.title2.bold())
                Spacer()
            }
            
            VStack {
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .overlay {
                        Image(uiImage: presentModelViewModel.uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        
                    }
                    .opacity(50)
                    .frame(width: 350, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                
                
                
                
                HStack {
                    Text("Описание")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 15)
                        .padding(.top, 25)
                    Spacer()
                }
                
                // https://fonts-online.ru/fonts/volja/download Скачать новые шрифты
                
                
                HStack {
                    Text(presentModelViewModel.present.presentDescription)
                        .frame(minHeight: 25, idealHeight: 25, maxHeight: 50)
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
                                .foregroundColor(.gray)
                                .opacity(15)
                                .padding(.leading, 15)
                            
                        } else {
                            Text("Подарок свободен")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.gray)
                                .opacity(15)
                                .padding(.leading, 15)
                        }
                        Spacer()
                    }
                }
                
                Divider()
                    .padding()
                
                // MARK: -- Кнопки удалить
                
                Button(action: {
                    presentModelViewModel.removingPresentFromWishlist(currentPresent.id)
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                .padding(.bottom, 15)
            }
        }
        .onAppear {
            presentModelViewModel.getPresentImage()
        }
//        .onFirstAppear {
//            presentModelViewModel.getPresentImage()
//        }
    }
}


public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            
            action()
        }
    }
}
