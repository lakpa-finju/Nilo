//
//  FoodsideView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct FoodsideView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        VStack{
            Text("Foodside").font(.system(.title))
            List(userManager.users, id:\.id){user in
                if user.location == "Foodside" {
                
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

struct FoodsideView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsideView().environmentObject(UserManager())
    }
}
