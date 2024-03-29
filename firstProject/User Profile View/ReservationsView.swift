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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("Reservations")
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(reservationsManager.personalizedReservation.sorted(by: {$0.key<$1.key}), id: \.key) {key, reservation in
                            if (reservation.reserverId == userProfileManager.geteUserId()){
                                VStack(spacing: 5) {
                                    Text(reservation.eventOrganizerName)
                                        .font(.system(.title))
                                    Text(reservation.eventOrganizerEmail)
                                        .font(.system(.title3))
                                    Text(dateFormatter.string(from: reservation.eventTime))
                                    
                                    if let profileImage = profileImagesManager.loadProfileImage(profileImageId: reservation.eventId){
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150,height: 150)
                                            .clipShape(Circle())
                                    }else{
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                            .shadow(radius: 7)
                                            .padding(.bottom, 20)
                                            
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
        .navigationTitle("Reservations")
     
        
    }
}

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView().environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
    }
}
