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
    @State private var reserverImage: UIImage?
    
    var body: some View {
        VStack {
            Text("Reservations")
                .font(.system(.title))
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(reservationsManager.reservations) { reservation in
                            if (reservation.id == userProfileManager.geteUserId()){
                                VStack(spacing: 5) {
                                    Text("Name: \(reservation.nameOfReserver)")
                                        .font(.system(.title))
                                    Text("Email: \(reservation.emailOfReserver)")
                                        .font(.system(.title3))
                                    //Display profile picture if there is one
                                    if let reserverImage = reserverImage{
                                        Image(uiImage: reserverImage)
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
                                       
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                            }
                            
                        }
                      Spacer() //to push the data to the top when there is only one data
                        
                    }
                    .onReceive(profileImagesManager.$profileImage, perform: { image in
                        reserverImage = image
                    })
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
