//
//  HillelView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct HillelView: View {
    @EnvironmentObject var eventManager: EventsManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    @State private var doesExist = false
    
    //this function awaits until we get response from the database
    private func updateDoesExist() async {
            doesExist = await reservationsManager.checkExistence(collectionsName: "Events", documentId: eventManager.geteUserId())
        }
    
    var body: some View {
        VStack {
            Text("Hillel")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventManager.events) { event in
                            if (event.location == "Hillel" && event.numberOfSwipes > 0){
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
                                        .environmentObject(eventManager)
                                }label: {
                                    Text("Offer Swipe(s)")
                                    Image(systemName: "plus")
                                }
                            }else{
                                NavigationLink{
                                    CancelEventView()
                                        .environmentObject(eventManager)
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
        .task {
                    await updateDoesExist()
                }
        
    }
}

struct HillelView_Previews: PreviewProvider {
    static var previews: some View {
        HillelView().environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
    }
}
