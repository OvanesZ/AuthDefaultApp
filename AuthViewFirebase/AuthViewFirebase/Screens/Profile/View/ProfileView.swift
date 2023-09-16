//
//  ProfileView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI
import Combine
import PhotosUI

struct ProfileView: View {
    
    @State var isAvatarlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    @StateObject var viewModel: ProfileViewModel
    @StateObject private var viewModelPhotoPicker = PhotoPickerViewModel()
    
    private let keyboardPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification in true } ,
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { notification in false }
    ).eraseToAnyPublisher()
    
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                
                
                if viewModelPhotoPicker.selectedImage == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFill()
//                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        .clipShape(Circle())
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    isQuitAlertPresented.toggle()
                                } label: {
                                    HStack {
                                        Text("Выйти")
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                    }
                                    .font(.body.bold())
                                    
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
                        }
                        .overlay(alignment: .bottomTrailing) {
                            PhotosPicker(selection: $viewModelPhotoPicker.imageSelection, matching: .images) {
                                Image(systemName: "pencil.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30))
                                    .foregroundColor(.accentColor)
                                    .padding(.trailing, 15)
                            }
                        }
                } else {
                    if let image = viewModelPhotoPicker.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        isQuitAlertPresented.toggle()
                                    } label: {
                                        HStack {
                                            Text("Выйти")
                                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                        }
                                        .font(.body.bold())
                                        
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
                            }
                            .overlay(alignment: .bottomTrailing) {
                                PhotosPicker(selection: $viewModelPhotoPicker.imageSelection, matching: .images) {
                                    Image(systemName: "pencil.circle.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .font(.system(size: 30))
                                        .foregroundColor(.accentColor)
                                        .padding(.trailing, 15)
                                }
                            }
                    }
                }
                
                //                Image(systemName: "person.badge.plus")
                //                    .resizable()
                //                    .frame(width: 140, height: 140)
                //                    .padding(8)
                //                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                //                    .clipShape(Circle())
                //                    .onTapGesture {
                //                        isAvatarlertPresented.toggle()
                //                    }
                //                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvatarlertPresented) {
                //                        Button {
                //                            print("Library")
                //
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
                //                    .toolbar {
                //                        ToolbarItem(placement: .navigationBarTrailing) {
                //                            Button {
                //                                isQuitAlertPresented.toggle()
                //                            } label: {
                //                                HStack {
                //                                    Text("Выйти")
                //                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                //                                }
                //                                .font(.body.bold())
                //
                //                            }
                //                            .confirmationDialog("Покинуть аккаунт?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                //                                Button {
                //                                    isAuthViewPresented.toggle()
                //                                } label: {
                //                                    Text("Да")
                //                                }
                //                            }
                //                            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                //                                AuthView()
                //                            }
                //
                //                        }
                //                    }
                
                
                
                Form {
                    Section(header: Text("Настройки профиля")) {
                        
                        TextField("Имя и Фамилия", text: $viewModel.profile.displayName)
                            .font(.body.bold())
                        
                        
                        HStack {
                            Text("+7")
                            TextField("Телефон", value: $viewModel.profile.phoneNumber, format: .number)
                                .keyboardType(.phonePad)
                        }
                        
                        DatePicker(selection: $viewModel.profile.dateOfBirth, displayedComponents: [.date]) {
                            Text("Дата рождения")
                        }
                        .datePickerStyle(.automatic)
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                    }
                    
                    
                    Section {
                        HStack {
                            Spacer()
                            Button {
                                viewModel.setProfile()
                                isShowAlert.toggle()
                                alertMessage = "Успешно!"
                            } label: {
                                Text("Подтвердить")
                            }
                            .alert(alertMessage, isPresented: $isShowAlert) {
                                Button {
                                    
                                } label: {
                                    Text("OK!")
                                }
                            }
                            Spacer()
                        }
                    }
                    
                }
            }
        }
        // Нажатие кнопки Return на клавиатуре
        .onSubmit {
            //            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
        }
        
        
        
        
    }
    
    
    
    
}
