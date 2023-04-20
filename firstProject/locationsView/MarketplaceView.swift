//
//  MarketplaceVIew.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct MarketplaceView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        List(userManager.users, id:\.id){user in
            if user.location == "Marketplace" {
                
                HStack{
                    Text(user.name)
                    Text("is eating at " + user.time)
                    
                }.font(.system(.body))
                    .foregroundColor(.black)
            }
        }
    }
}

struct MarketplaceVIew_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView().environmentObject(UserManager())
    }
}
