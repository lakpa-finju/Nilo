//
//  FiresideView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct FiresideView: View {
    @EnvironmentObject var eventsManager: EventsManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @EnvironmentObject var profileImagesManager: ProfileImagesManager
    @State private var doesExist = false
    @State private var showPersonalizedReservationsView = false
    @State private var showPeopleReservationsView = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a zzz"
        return formatter
    }()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(eventsManager.events.sorted(by: {$0.key < $1.key}), id:\.key) { key, event in
                            if (event.location == "Fireside" && event.numberOfSwipes > 0){
                                VStack(spacing: 10) {
                                    Text("\(event.name) is eating on \(dateFormatter.string(from: event.time))")
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
        .sheet(isPresented: $showPersonalizedReservationsView, content: {
            ReservationsView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
                .environmentObject(profileImagesManager)
        })
        .sheet(isPresented: $showPeopleReservationsView, content: {
            AttendeesRoasterView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
                .environmentObject(profileImagesManager)
        })
        .navigationTitle("Fireside")
        .onAppear{
            doesExist = eventsManager.checkExistence(eventId: eventsManager.geteUserId())
            if !reservationsManager.personalizedReservation.isEmpty{
                showPersonalizedReservationsView = true
            }
            if !reservationsManager.peopleReservation.isEmpty{
                showPeopleReservationsView = true
            }
        }
    }
}

struct FiresideView_Previews: PreviewProvider {
    static var previews: some View {
        FiresideView().environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
    }
}
