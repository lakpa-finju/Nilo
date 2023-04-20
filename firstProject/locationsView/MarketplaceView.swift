//
//  MarketplaceVIew.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct MarketplaceView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showPopup = false
    
    var body: some View {
        VStack{
            Text("Marketplace").font(.system(.title))
            List(userManager.users, id:\.id){user in
                if user.location == "Marketplace" {
                    
                    HStack{
                        Text(user.name)
                        Text("is eating at " + user.time)// make this a button to show futher information. 
                        
                    }.font(.system(.body))
                     
                }
            }
        }
        .offset(y:-40)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    showPopup.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            })
        }
        .sheet(isPresented: $showPopup) {
            //new user view
            NewSwipeView()
            
        }
        
    }
}

struct MarketplaceVIew_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView().environmentObject(UserManager())
    }
}
