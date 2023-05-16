//
//  CancelEventView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-24.
//

import SwiftUI

struct CancelEventView: View {
    @EnvironmentObject private var eventsManager: EventsManager
    @EnvironmentObject private var reservationsManager: ReservationsManager
    var body: some View {
        VStack {
            Text("Cancel swipe offering")
                .font(.system(.title))
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventsManager.events.sorted(by: {$0.key < $1.key}), id:\.key) { key, event in
                            if (event.id == eventsManager.geteUserId()){
                                Spacer()
                                VStack(spacing: 5) {
                                    
                                    Text("Name: \(event.name)")
                                        .font(.system(.title2))
                                    Text("Time: \(event.time)")
                                        .font(.system(.title3))
                                    
                                    HStack {
                                        Text("Available swipe(s): \(event.numberOfSwipes)")
                                        Spacer()
                                        Text("Reserved: \(event.reserved)")
                                    }
                                    
                                    Button(action: {
                                        eventsManager.deleteEvent(event: event)
                                        reservationsManager.deleteReservationsWithCondition(eventId: event.id)
                                    }, label: {
                                        Text("Cancel Offer")
                                            .foregroundColor(Color.white)
                                            .padding(.all, 10)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    })
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                            }
                            
                        }
                      Spacer() //to push the data to the top when there is only one data
                        
                    }
                   /* .onReceive(profileImagesManager.$eventOrganizerImage, perform: { image in
                        eventOrganizerImage = image
                    }) */
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
        }
        
    }
}

struct CancelEventView_Previews: PreviewProvider {
    static var previews: some View {
        CancelEventView().environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
    }
}
