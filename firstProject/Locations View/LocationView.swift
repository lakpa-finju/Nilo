//
//  LocationView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var eventsManager: EventsManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    @State private var doesExist = false

    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]
    
    var body: some View {
       // NavigationStack {
            ZStack{
                //this is for background
                Color.white
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 800)
                    .rotationEffect(.degrees(135))
                    .offset(x:70,y:-400)
                
                VStack(alignment: .center, spacing: 10){
                    //for Marketplace
                    NavigationLink{
                        MarketplaceView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                            
                    }label: {
                        Text("Marketplace")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //for Cafe 77
                    NavigationLink{
                        Cafe77View()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Cafe 77")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                    }
                    
                    //for Hillel
                    NavigationLink{
                        HillelView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Hillel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //for Fireside
                    NavigationLink{
                        FiresideView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Fireside")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //For Foodside
                    NavigationLink{
                        FoodsideView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Foodside")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //For Brief Stop
                    NavigationLink{
                        BriefstopView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Brief Stop")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                   
                    //Foot note
                    HStack {
                        Spacer()
                        Text("© 2023 - Created by Lakpa F. Sherpa")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .offset(y:190)
                        Spacer()
                    }
                    
                }
                .offset(y:-70)
                .navigationTitle("Locations")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        if (doesExist == false){
                            NavigationLink{
                                NewSwipeView()
                                    .environmentObject(eventsManager)
                            }label: {
                                Text("Offer Swipe(s)")
                            }
                        }else{
                            NavigationLink{
                                CancelEventView()
                                    .environmentObject(eventsManager)
                                    .environmentObject(reservationsManager)
                            }label: {
                                Text("Cancel my Offer")
                            }
                        }
                        
                        
                    })
                    
                }
                
            }
            .onAppear{
                doesExist = eventsManager.checkExistence(eventId: eventsManager.geteUserId())
            }
            .accentColor(Color(.label))
  
    }
    
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
        
            
    }
}
