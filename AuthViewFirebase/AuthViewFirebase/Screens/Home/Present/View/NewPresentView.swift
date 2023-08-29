//
//  NewPresentView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 29.08.2023.
//

import SwiftUI

struct NewPresentView: View {
    
    @State private var presentName = ""
    @State private var presentUrlForMarket = ""
    @State private var presentDescription = ""
    @State private var isHiddenToolBar = false
    @ObservedObject var viewModel: PresentModelViewModel
    @ObservedObject var userViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    //    @GestureState private var dragOffset = CGSize.zero
    @State var isPhotoLibrary = false
    
//    @StateObject var viewModelImage = ProfileModel()
    
    var body: some View {
        

        
        
        
        VStack {
            HStack {
                Spacer()
//                EditableRectanglePresentImage(viewModel: viewModelImage)
                Spacer()
            }
            .padding(.top, 25)
            
            
            HStack {
                Text("Название")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .padding(.top, 15)
                Spacer()
            }
            
            TextField("Название подарка", text: $presentName)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            //                    .textFieldStyle(OvalTextFieldStyle())
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
            
            Divider()
            
            HStack {
                Text("Описание")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            
            TextField("Описание подарка", text: $presentDescription)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            //                    .textFieldStyle(OvalTextFieldStyle())
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
            
            Divider()
            
            HStack {
                Text("Ссылка на подарок")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                Spacer()
            }
            
            TextField("Ссылка на подарок", text: $presentUrlForMarket)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
            //                    .textFieldStyle(OvalTextFieldStyle())
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
            
            VStack {
                Spacer()
                
                Button(action: {
                    let present = PresentModel(name: presentName, urlText: presentUrlForMarket, presentDescription: presentDescription)

                    viewModel.loadNewPresentInCollection(present)
                    dismiss()
                }) {
                    HStack {
                        Text("Создать")
                            .padding(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.top, 20)
            }
        }
        Spacer()
    }
}


