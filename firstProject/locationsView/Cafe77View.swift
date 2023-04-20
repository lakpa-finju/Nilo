//
//  Cafe77View.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct Cafe77View: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        List(userManager.users, id:\.id){user in
            if user.location == "Cafe 77" {
            
                HStack{
                    Text(user.name)
                    Text("is eating at " + user.time)
                    
                }.font(.system(.body))
                    .foregroundColor(.black)
            }
        }
    }

}

struct Cafe77View_Previews: PreviewProvider {
    static var previews: some View {
        Cafe77View().environmentObject(UserManager())
    }
}
