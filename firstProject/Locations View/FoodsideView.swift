//
//  FoodsideView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct FoodsideView: View {
    @EnvironmentObject var eventsManager: EventsManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    @State private var doesExist = false
  
    var body: some View {
        VStack {
            Text("Foodside")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventsManager.events.sorted(by: {$0.key < $1.key}), id:\.key) { key, event in
                            if (event.location == "Foodside" && event.numberOfSwipes > 0){
                                VStack(spacing: 10) {
                                    Text("\(event.name) is eating at \(event.time)")
                                            .font(.system(.title3))
                                            .foregroundColor(Color.black)
                                            .bold()
                                    
                                    if (event.message != ""){
                                        Text("Message: \(event.message)")
                                    }
                                    
                                HStack {
                                    Text("Available swipe(s): \(event.numberOfSwipes)")
                                    Spacer()
                                    Text("Reserved: \(event.reserved)")
                                }
                                
                                    // if User has set an event that is offered a swipe, they shouldn't see a reserve btn
                                    if (doesExist == false){
                                        Button(action: {
                                            reservationsManager.reserveSpot(for: event)
                                            
                                        }, label: {
                                            Text("Reserve")
                                                .foregroundColor(Color.white)
                                                .padding(.all, 10)
                                                .background(Color.blue)
                                                .cornerRadius(10)
                                        })
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
                            if (doesExist == false){
                                NavigationLink{
                                    NewSwipeView()
                                        .environmentObject(eventsManager)
                                }label: {
                                    Text("Offer Swipe(s)")
                                    Image(systemName: "plus")
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
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .onAppear{
            doesExist = eventsManager.checkExistence(eventId: eventsManager.geteUserId())
        }
        
    }
}

struct FoodsideView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsideView().environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
    }
}
