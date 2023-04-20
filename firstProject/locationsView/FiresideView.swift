//
//  FiresideView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct FiresideView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        List(userManager.users, id:\.id){user in
            if user.location == "Fireside" {
                
                HStack{
                    Text(user.name)
                    Text("is eating at " + user.time)
                    
                }.font(.system(.body))
                    .foregroundColor(.black)
            }
        }
    }
}

struct FiresideView_Previews: PreviewProvider {
    static var previews: some View {
        FiresideView().environmentObject(UserManager())
    }
}
