//
//  ContentView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 19.08.2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var login = ""
    @State private var password = ""
    @State private var verifyPassword = ""
    @State private var isAuth = false
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
       
        
        VStack {
            
            Text(isAuth ? "Регистрация" : "Авторизация")
                .padding()
                .padding(.horizontal, 30)
                .font(.largeTitle)
                .background(Color.orange)
                .cornerRadius(30)
            
            TextField("Логин", text: $login)
                .textFieldStyle(.roundedBorder)
                .cornerRadius(12)
                .padding(8)
                .padding(.horizontal, 12)
            
            SecureField("Введите пароль", text: $password)
                .textFieldStyle(.roundedBorder)
                .cornerRadius(12)
                .padding(8)
                .padding(.horizontal, 12)
            
            if isAuth {
                SecureField("Повторите пароль", text: $verifyPassword)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
            }
            
            Button {
                if !isAuth {
                    print("Авторизация через Firebase")
                    
                    AuthService.shared.signIn(email: self.login, password: self.password) { result in
                        switch result {
                        case .success(_):
                            isTabViewShow.toggle()
                        case .failure(let error):
                            alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                            isShowAlert.toggle()
                        }
                    }
                    
                } else {
                    print("Registration")
                    
                    
                    guard password == verifyPassword else {
                        self.alertMessage = "Пароли не совпадают!"
                        self.isShowAlert.toggle()
                        return
                    }
                    
                    AuthService.shared.signUp(email: self.login, password: self.password) { result in
                        switch result {
                        case .success(let user):
                            
                            alertMessage = "Вы зарегитсрировались с email \(user.email ?? "")"
                            self.isShowAlert.toggle()
                            self.login = ""
                            self.password = ""
                            self.verifyPassword = ""
                            self.isAuth.toggle()
                        case .failure(let error):
                            
                            alertMessage = "Ошибка регистрации! \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                    
                    
                }
            } label: {
                Text(isAuth ? "Зарегистрироваться" : "Войти")
            }
            .buttonStyle(.bordered)
           
            
            
            Button {
                isAuth.toggle()
            } label: {
                Text(isAuth ? "Уже есть аккаунт" : "Нет аккаунта?")
            }
            .padding()
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button {
                    
                } label: {
                    Text("OK!")
                }

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("bg")
            .resizable()
            .ignoresSafeArea()
            .blur(radius: isAuth ? 6 : 0))
        .animation(Animation.easeInOut(duration: 0.4), value: isAuth)
        .fullScreenCover(isPresented: $isTabViewShow) {
            
            let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
            
            MainTabBar(viewModel: mainTabBarViewModel)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
