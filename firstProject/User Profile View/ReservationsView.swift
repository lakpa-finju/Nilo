//
//  ReservationsView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//

import SwiftUI

struct ReservationsView: View {
    @EnvironmentObject var reservationsManager: ReservationsManager
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @EnvironmentObject var profileImagesManager: ProfileImagesManager

    var body: some View {
        VStack {
            Text("Reservations")
                .font(.system(.title))
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(reservationsManager.reservations.sorted(by: {$0.key<$1.key}), id: \.key) {key, reservation in
                            if (reservation.reserverId == userProfileManager.geteUserId()){
                                VStack(spacing: 5) {
                                    Text("Name: \(reservation.eventOrganizerName)")
                                        .font(.system(.title))
                                    Text("Email: \(reservation.eventOrganizerEmail)")
                                        .font(.system(.title3))
                                    //Display profile picture if there is one
                                    if let eventOrganizerImage = profileImagesManager.loadProfileImage(profileImageId: reservation.eventId){
                                        Image(uiImage: eventOrganizerImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150,height: 200)
                                            .clipShape(Circle())

                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray)
                                            .padding()
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                                    }
                                    Button {
                                        reservationsManager.cancelSpot(for: reservation)
                                    } label: {
                                        Text("Cancel Reservation")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    }



                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                            }
                            
                        }
                      Spacer() //to push the data to the top when there is only one data
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
        }
        
    }
}

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView().environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
    }
}
