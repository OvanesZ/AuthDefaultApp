//
//  FirstView.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 20.08.2023.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    
    
    @State private var isShowingNewPresentView = false
    @ObservedObject var viewModel: HomeViewModel
    
    
    private var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 20),
        GridItem(.fixed(150), spacing: 20)
    ]
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                // MARK: -- LazyVGrid
                
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center, // позволяет нам выровнять содержимое сетки с помощью перечисления HorizontalAlignment для LazyVGrid и VerticalAlignment для LazyHGrid. Работает так же, как stack alignment
                        spacing: 15, // расстояние между каждой строкой внутри
                        pinnedViews: [.sectionFooters]
                    ) {
                        Section() {
                            ForEach(viewModel.mockWishlist) { present in
                                PresentCellView(present: present)
                            }
                        }
                    }
                }
                
                Button {
                    isShowingNewPresentView = true
                } label: {
                    Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                }
                .font(.system(size: 70))
                .opacity(0.8)
                .padding(.leading, 250)
                .padding(.top, 420)
                .sheet(isPresented: $isShowingNewPresentView) {
//                    NewPresentView(viewModel: PresentModelViewModel(present: PresentModel()), userViewModel: UserViewModel())
                }
//                .preferredColorScheme(.dark)
//                .toolbarColorScheme(.dark, for: .tabBar)
                .navigationTitle("Мои пожелания \(Auth.auth().currentUser?.email ?? "")")
                
            }
            .toolbar(.visible, for: .tabBar)      // tabBar постоянно на видимом фоне
        }
        
        
    }
}







//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
