//
//  BriefstopView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct BriefstopView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        List(userManager.users, id:\.id){user in
            if user.location == "Brief Stop" {
            
                HStack{
                    Text(user.name)
                    Text("is eating at " + user.time)
                    
                }.font(.system(.body))
                    .foregroundColor(.black)
            }
        }
    }
}

struct BriefstopView_Previews: PreviewProvider {
    static var previews: some View {
        BriefstopView().environmentObject(UserManager())
    }
}
