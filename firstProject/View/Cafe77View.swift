//
//  Cafe77View.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct Cafe77View: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {

        VStack{
            Text("Cafe 77").font(.system(.title))
            List(eventManager.events, id:\.id){event in
                if (event.location == "Cafe 77" && event.numberOfSwipes > 0){
                    VStack {
                        HStack {
                            Text("\(event.name) is eating at \(event.time)")
                                .font(.system(.body))
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
                            Text("Available Seats: \(event.numberOfSwipes)")
                            Spacer()
                            Text("Reserved Seats: \(event.reserved)")
                        }
                    }
                }
            }
        }
        .offset(y:-40)
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

struct Cafe77View_Previews: PreviewProvider {
    static var previews: some View {
        Cafe77View().environmentObject(EventManager())
            .environmentObject(ReservationsManager())
    }
}
