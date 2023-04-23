//
//  FoodsideView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct FoodsideView: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {
        VStack {
            Text("Foodside")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventManager.events) { event in
                            if (event.location == "Foodside" && event.numberOfSwipes > 0){
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
                                    })                                }
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

struct FoodsideView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsideView().environmentObject(EventManager())
            .environmentObject(ReservationsManager())
    }
}
/*
struct FoodsideView: View {
    @EnvironmentObject var eventManager: EventManager
    @EnvironmentObject var reservationManager: ReservationsManager
    @State private var showPopup = false
    
    var body: some View {
        VStack{
            Text("Foodside").font(.system(.title))
            GeometryReader{ geometry in
                ScrollView (.vertical, showsIndicators: true) {
                    /*
                    VStack (spacing:7){
                        ForEach(0..<50) { index in
                            Text("Item \(index)")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.blue)
                            
                        }
                        
                        */
                         
                         List(eventManager.events, id:\.id){event in
                         if (event.location == "Foodside" && event.numberOfSwipes > 0){
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
                    //this prevents the first item cut off from scroll view top
                    .offset(y:50)
                    
                } // for scroll view
                .frame(width: geometry.size.width, height: geometry.size.height)
                
            }//for geometry veiw
            
        }//vstack
    }
}

struct FoodsideView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsideView().environmentObject(EventManager())
            .environmentObject(ReservationsManager())
    }
}
*/
