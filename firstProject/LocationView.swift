//
//  LocationView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var userManager : UserManager
    @State private var showPopup = false
    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10){
                //for Marketplace
                NavigationLink{
                    MarketplaceView()
                }label: {
                    Text("Marketplace")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
            
                //for Cafe 77
                NavigationLink{
                    Cafe77View()
                }label: {
                    Text("Cafe 77")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
            
                //for Hillel
                NavigationLink{
                    HillelView()
                }label: {
                    Text("Hillel")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
            
                //for Fireside
                NavigationLink{
                    FiresideView()
                }label: {
                    Text("Fireside")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
        
                //For Foodside
                NavigationLink{
                    FoodsideView()
                }label: {
                    Text("Foodside")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
            
                //For Brief Stop
                NavigationLink{
                    BriefstopView()
                }label: {
                    Text("Brief Stop")
                        .font(.system(.title))
                        .foregroundColor(.blue)
                }
            
            
        }
        .offset(y:-70)
        .navigationTitle("Locations")
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
    
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(UserManager())
    }
}
