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
            ZStack{
                //this is for background
                Color.white
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.white,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y:-35)
                
                VStack(alignment: .center, spacing: 10){
                    //for Marketplace
                    NavigationLink{
                        MarketplaceView()
                    }label: {
                        Text("Marketplace")
                            .bold()
                            .foregroundColor(.black)
                            .font(.title)
                            
                    }
                    
                    //for Cafe 77
                    NavigationLink{
                        Cafe77View()
                    }label: {
                        Text("Cafe 77")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    
                    //for Hillel
                    NavigationLink{
                        HillelView()
                    }label: {
                        Text("Hillel")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    
                    //for Fireside
                    NavigationLink{
                        FiresideView()
                    }label: {
                        Text("Fireside")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    
                    //For Foodside
                    NavigationLink{
                        FoodsideView()
                    }label: {
                        Text("Foodside")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    
                    //For Brief Stop
                    NavigationLink{
                        BriefstopView()
                    }label: {
                        Text("Brief Stop")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    
                    
                }
                .offset(y:-70)
                .navigationTitle("Locations")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        NavigationLink{
                            NewSwipeView()
                        }label: {
                            Text("Offer Swipe(s)")
                            Image(systemName: "plus")
                        }
                        
                        
                    })
                }
            }
         
            
        }
    }
    
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(UserManager())
    }
}
