//
//  PresentCellView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 28.08.2023.
//

import SwiftUI

struct PresentCellView: View {

    let present: PresentModel
    @State var isShowPresentCell = false
    @GestureState private var isLongPressed = false
    @StateObject var viewModel = PresentModelViewModel(present: PresentModel(name: "", urlText: "", presentFromUserID: ""))
    
    // MARK: - init()
    init(present: PresentModel) {
        self.present = present
    }

    var body: some View {
        
        VStack {
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
                                        Image(uiImage: viewModel.uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                        
                                    }
                                    .opacity(50)
                                    .frame(width: 130, height: 130)
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                                    .overlay(alignment: .bottomLeading) {
//                                        Text(present.name)
//                                            .padding(.leading, 15)
//                                            .padding(.bottom, 10)
//                                            .padding(.top, 10)
//                                            .foregroundColor(.white)
//                                            .font(.callout.bold())
//                                    }
                            }
                        }
                    }
                    .sheet(isPresented: $isShowPresentCell) {
                        PresentModalView(currentPresent: present, presentModelViewModel: PresentModelViewModel(present: present))
                    }
                }
            
                .onAppear {
                    StorageService.shared.downloadPresentImage(id: present.id) { result in
                        switch result {
                        case .success(let data):
                            if let img = UIImage(data: data) {
                                self.viewModel.uiImage = img
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            Text(present.name)
                .font(.callout.bold())
                .padding(.top, 3)
            
            Spacer()
        }
    }
    
}




//struct PresentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentCellView(present: PresentModel(name: "Iphone", havePhoto: true, urlText: "https://ozone.ru", isReserved: false, presentFromUser: UserModel(), presentImageURLText: "https://ozon.ru", presentDescription: "Red phone. 512 Gb. ProMax."))
//    }
//}
