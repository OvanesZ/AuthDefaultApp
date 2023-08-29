//
//  ProfileView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvatarlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    
    @StateObject var viewModel: ProfileViewModel
    
    @State var name = "Имя Фамилия"
    @State var phone = 9055709845
    @State var address = "Ваш адрес будет тут"
    
    
    var body: some View {
        
        VStack() {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvatarlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvatarlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галереи")
                        }
                        
                        Button {
                            print("Camera")
                        } label: {
                            Text("Из камеры")
                        }
                    }
                
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.displayName)
                        .font(.body.bold())
                    
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phoneNumber, format: .number)
                    }
                }
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Адрес")
                TextField("адрес", text: $viewModel.profile.address)
            }.padding()
            
            
            Spacer()
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding()
            .confirmationDialog("Покинуть аккаунт?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                Button {
                    isAuthViewPresented.toggle()
                } label: {
                    Text("Да")
                }
            }
            
            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                AuthView()
            }

            
            
        }
        // Нажатие кнопки Return на клавиатуре
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
        }
        
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "", displayName: "Имя Фамилия", phone: 9055709845, address: "Ваш адрес будет тут")))
//    }
//}
