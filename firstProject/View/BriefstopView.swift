//
//  BriefstopView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct BriefstopView: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {
        VStack {
            Text("Brief Stop")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventManager.events) { event in
                            if (event.location == "Brief Stop" && event.numberOfSwipes > 0){
                                VStack(spacing: 10) {
                                HStack {
                                    Text("\(event.name) is eating at \(event.time)")
                                        .font(.system(.title3))
                                        .foregroundColor(Color.black)
                                        .bold()
                                    Spacer()
                                    Button(action: {
                                        reservationManager.reserveSpot(for: event)
                                        
                                    }, label: {
                                        Text("Reserve")
                                            .foregroundColor(Color.white)
                                            .padding(.all, 10)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    })
                                    
                                }
                                HStack {
                                    Text("Available swipe(s): \(event.numberOfSwipes)")
                                    Spacer()
                                    Text("Reserved: \(event.reserved)")
                                }
                            }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                        }
                        }
                        
                    }
                    .padding()
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
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        
    }
}

struct BriefstopView_Previews: PreviewProvider {
    static var previews: some View {
        BriefstopView().environmentObject(EventManager())
            .environmentObject(ReservationsManager())
    }
}
