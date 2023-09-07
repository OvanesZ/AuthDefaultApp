//
//  ProfileView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI

//struct ProfileView: View {
//
//    @State var isAvatarlertPresented = false
//    @State var isQuitAlertPresented = false
//    @State var isAuthViewPresented = false
//
//    @StateObject var viewModel: ProfileViewModel
//
//    @State var name = "Имя Фамилия"
//    @State var phone = 9055709845
//    @State var address = "Ваш адрес будет тут"
//
//
//    var body: some View {
//
//        VStack() {
//
//                Image(systemName: "person")
//                    .resizable()
//                    .frame(width: 80, height: 80)
//                    .padding(8)
//                    .background(Color.gray)
//                    .clipShape(Circle())
//                    .onTapGesture {
//                        isAvatarlertPresented.toggle()
//                    }
//                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvatarlertPresented) {
//                        Button {
//                            print("Library")
//                        } label: {
//                            Text("Галерея")
//                        }
//
//                        Button {
//                            print("Camera")
//                        } label: {
//                            Text("Камера")
//                        }
//                    }
//
//                VStack(alignment: .leading, spacing: 12) {
//                    TextField("Имя", text: $viewModel.profile.displayName)
//                        .font(.body.bold())
//
//                    HStack {
//                        Text("+7")
//                        TextField("Телефон", value: $viewModel.profile.phoneNumber, format: .number)
//                            .keyboardType(.phonePad)
//                    }
//                }
//
//            VStack(alignment: .leading) {
//                Text("Адрес")
//                TextField("адрес", text: $viewModel.profile.address)
//            }.padding()
//
//
//            Spacer()
//
//            Button {
//                isQuitAlertPresented.toggle()
//            } label: {
//                Text("Выйти")
//                    .padding()
//                    .padding(.horizontal, 30)
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//            }
//            .padding()
//            .confirmationDialog("Покинуть аккаунт?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
//                Button {
//                    isAuthViewPresented.toggle()
//                } label: {
//                    Text("Да")
//                }
//            }
//
//            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
//                AuthView()
//            }
//
//
//
//        }
//        // Нажатие кнопки Return на клавиатуре
//        .onSubmit {
//            viewModel.setProfile()
//        }
//        .onAppear {
//            self.viewModel.getProfile()
//        }
//
//    }
//}



struct ProfileView: View {

    @State var isAvatarlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false

    @StateObject var viewModel: ProfileViewModel



    var body: some View {

        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 120, height: 120)
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
                        Text("Галерея")
                    }

                    Button {
                        print("Camera")
                    } label: {
                        Text("Камера")
                    }
                }


            VStack {
                Form {
                    Section(header: Text("Настройки профиля")) {

                        TextField("Имя и Фамилия", text: $viewModel.profile.displayName)
                            .font(.body.bold())


                        HStack {
                            Text("+7")
                            TextField("Телефон", value: $viewModel.profile.phoneNumber, format: .number)
                                .keyboardType(.phonePad)
                        }


//                        HStack {
//                            Text("+7")
//                            TextField("Телефон", text: $viewModel.profile.phoneNumber)
//                                .keyboardType(.phonePad)
//                        }

//                        TextField("Дата рождения", text: $viewModel.profile.dateOfBirth)
//                            .font(.body.bold())

                        DatePicker(selection: $viewModel.profile.dateOfBirth, displayedComponents: [.date]) {
                            Text("")
                        }
                        .datePickerStyle(.wheel)
                    }

                }
            }

            Spacer()

            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .font(.body.bold())
                    .padding()
                    .padding(.horizontal, 40)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
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
