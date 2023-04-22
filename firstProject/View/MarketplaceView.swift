//
//  MarketplaceVIew.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct MarketplaceView: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {
        
        VStack{
            Text("Marketplace").font(.system(.title))
            List(eventManager.events, id:\.id){event in
                if event.location == "Marketplace" {
                    VStack {
                        HStack {
                            Text("\(event.name) is eating at \(event.time)")
                                .font(.system(.body))
                                .foregroundColor(Color.black)
                                .bold()
                            Spacer()
                            Button(action: {
                                reservationManager.reserveSpot(for: event)
                                    
                                //reserveSpot(for: event)
                            }, label: {
                                Text("Reserve")
                                    .foregroundColor(Color.white)
                                    .padding(.all, 10)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            })
                        }
                        HStack {
                            Text("Available Seats: \(event.numberOfSwipes)")
                            Spacer()
                            Text("Reserved Seats: \(event.reserved)")
                        }
                    }
                }
            }
        }
        .offset(y:-10)
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
    //This will sent call the reserveSpot function in reservation Manager
    private func reserveSpot(for event: Event) {
        if event.numberOfSwipes > 0 {
            reservationManager.reserveSpot(for: event)
                
        } else {
            showPopup = true
        }
    }
}

struct MarketplaceView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView()
            .environmentObject(EventManager())
            .environmentObject(ReservationsManager())
    }
}

/*
import SwiftUI

struct MarketplaceView: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {
        
        VStack{
            Text("Marketplace").font(.system(.title))
            List(eventManager.events, id:\.id){event in
                if event.location == "Marketplace" {
                    
                   /* NavigationLink{
                        //create a button like object
                        //UserProfileView()
                    }label: {
                        Text("\(event.name) is eating at \(event.time)")
                            .font(.system(.body))
                            .foregroundColor(Color.black)
                            .bold()
                    }*/
                    
                    
                    
                    
                }
            }
            
        }
        .offset(y:-10)
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

struct MarketplaceVIew_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView().environmentObject(EventManager())
    }
}
*/
