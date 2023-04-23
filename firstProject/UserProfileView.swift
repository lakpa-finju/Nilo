//
//  UserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI
struct UserProfileView: View {
    @EnvironmentObject var eventManger: EventManager
    @EnvironmentObject var userProfileManager: UserProfileManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            
            //Display Name and Email address right below profile picture
            Text(userProfileManager.getUserName())
                .font(.title)
            Text(userProfileManager.getUserEmail())
                .font(.body)
            
            NavigationLink(destination: ChangeEmailView()) {
                Text("Change Email")
                    .foregroundColor(.blue)
            }
            
            NavigationLink(destination: ChangePasswordView()
                .environmentObject(userProfileManager)
            
            ) {
                Text("Change Password")
                    .foregroundColor(.blue)
            }
            
            NavigationLink(destination: ReservationsView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
            ) {
                Text("My Reservations")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Profile")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(EventManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfileManager())
        
    }
}
