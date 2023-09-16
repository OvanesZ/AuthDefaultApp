//
//  ProfileView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI
import Combine
//import PhotosUI

struct ProfileView: View {
    
    @State var isAvatarlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    @State private var showImagePickerLibrary = false
    @State private var showImagePickerCamera = false
    //    @State private var image = UIImage(named: "person")!
    
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
                
                // MARK: - Photo Picker
                
                //                if viewModelPhotoPicker.selectedImage == nil {
                //                    Image(systemName: "person.circle.fill")
                //                        .resizable()
                //                        .frame(width: 200, height: 200)
                //                        .scaledToFill()
                //                        .clipShape(Circle())
                //                        .toolbar {
                //                            ToolbarItem(placement: .navigationBarTrailing) {
                //                                Button {
                //                                    isQuitAlertPresented.toggle()
                //                                } label: {
                //                                    HStack {
                //                                        Text("Выйти")
                //                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                //                                    }
                //                                    .font(.body.bold())
                //
                //                                }
                //                                .confirmationDialog("Покинуть аккаунт?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                //                                    Button {
                //                                        isAuthViewPresented.toggle()
                //                                    } label: {
                //                                        Text("Да")
                //                                    }
                //                                }
                //                                .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                //                                    AuthView()
                //                                }
                //
                //                            }
                //                        }
                //                        .overlay(alignment: .bottomTrailing) {
                //                            PhotosPicker(selection: $viewModelPhotoPicker.imageSelection, matching: .images) {
                //                                Image(systemName: "pencil.circle.fill")
                //                                    .symbolRenderingMode(.multicolor)
                //                                    .font(.system(size: 30))
                //                                    .foregroundColor(.accentColor)
                //                                    .padding(.trailing, 15)
                //                            }
                //                        }
                //                } else {
                //                    if let image = viewModelPhotoPicker.selectedImage {
                //                        Image(uiImage: image)
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 200, height: 200)
                //                            .clipShape(Circle())
                //                            .toolbar {
                //                                ToolbarItem(placement: .navigationBarTrailing) {
                //                                    Button {
                //                                        isQuitAlertPresented.toggle()
                //                                    } label: {
                //                                        HStack {
                //                                            Text("Выйти")
                //                                            Image(systemName: "rectangle.portrait.and.arrow.right")
                //                                        }
                //                                        .font(.body.bold())
                //
                //                                    }
                //                                    .confirmationDialog("Покинуть аккаунт?", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                //                                        Button {
                //                                            isAuthViewPresented.toggle()
                //                                        } label: {
                //                                            Text("Да")
                //                                        }
                //                                    }
                //                                    .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                //                                        AuthView()
                //                                    }
                //
                //                                }
                //                            }
                //                            .overlay(alignment: .bottomTrailing) {
                //                                PhotosPicker(selection: $viewModelPhotoPicker.imageSelection, matching: .images) {
                //                                    Image(systemName: "pencil.circle.fill")
                //                                        .symbolRenderingMode(.multicolor)
                //                                        .font(.system(size: 30))
                //                                        .foregroundColor(.accentColor)
                //                                        .padding(.trailing, 15)
                //                                }
                //                            }
                //                    }
                //                }
                
                
                // MARK: - Image Picker
                
                
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvatarlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvatarlertPresented) {
                        Button {
                            showImagePickerLibrary.toggle()
                            
                        } label: {
                            Text("Галерея")
                        }
                        
                        Button {
                            showImagePickerCamera.toggle()
                            
                        } label: {
                            Text("Камера")
                        }
                    }
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
                    .sheet(isPresented: $showImagePickerLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
                    }
                    .sheet(isPresented: $showImagePickerCamera) {
                        ImagePicker(sourceType: .camera, selectedImage: $viewModel.image)
                    }
                
                
                
                
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
