//
//  FriendsCell.swift
//  AuthViewFirebase
//
//  Created by Ованес Захарян on 29.08.2023.
//

import SwiftUI
import Kingfisher

struct FriendsCell: View {
    
    let friend: UserModel
    
    init(friend: UserModel) {
        self.friend = friend
    }
    
    var body: some View {
        
        
        HStack {
            
            KFImage(friend.userImage)
                .resizable()
                .frame(width: 38, height: 38)
                .clipShape(Circle())
            
            
            Text(friend.email)
                .padding(.leading, 3)
                .lineLimit(2)
                .bold()
//                .foregroundColor(Color(#colorLiteral(red: 0.9649916291, green: 0.9558705688, blue: 0.871204555, alpha: 1)))
            
//            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.04370719939, green: 0.1099352911, blue: 0.1132253781, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
}

extension Text {
    func boldItalic() -> Text {
        self.bold().italic()
    }
}

struct FriendsCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendsCell(friend: UserModel(id: "1", email: "test@test.com", displayName: "Test", phoneNumber: 000, address: "111", userImageURLText: "https://i.klerk.ru/PeBvi-xi1wovZDomiEcqboxWA1GCQW2Ia1wBGU_KkyI/rs:fit/w:674/h:235/q:100/aHR0cHM6Ly93d3cu/a2xlcmsucnUvdWdj/L2Jsb2dQb3N0LzUw/MjU0Ny8xLnBuZw.webp"))
    }
}
