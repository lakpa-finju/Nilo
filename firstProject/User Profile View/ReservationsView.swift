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
                        ForEach(reservationsManager.reservations) { reservation in
                            if (reservation.id == userProfileManager.geteUserId()){
                                VStack(spacing: 10) {
                                    Text("Name: \(reservation.nameOfReserver)")
                                    Text("Email: \(reservation.emailOfReserver)")
                                    
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                            }
                            
                        }
                      
                        
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
