//
//  HillelView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct HillelView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack{
            Text("Hillel").font(.system(.title))
            List(userManager.users, id:\.id){user in
                if user.location == "Hillel" {
                    
                    HStack{
                        Text(user.name)
                        Text("is eating at " + user.time)
                        
                    }.font(.system(.body))
                        .foregroundColor(.black)
                }
            }

        }
        .offset(y:-40)
    }
}

struct HillelView_Previews: PreviewProvider {
    static var previews: some View {
        HillelView().environmentObject(UserManager())
    }
}
