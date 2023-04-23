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
        VStack(spacing: 6) {
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
            
            //upate Name
            NavigationLink(destination: UpdateUserNameView()
                .environmentObject(userProfileManager)) {
                Text("Change Name")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)            }

            
            //upate email
            NavigationLink(destination: UpdateEmailView()
                .environmentObject(userProfileManager)) {
                Text("Change Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
            }
            
            //update Password
            NavigationLink(destination: UpdatePasswordView()
                .environmentObject(userProfileManager)
            
            ) {
                Text("Change Password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            //list of reservations
            NavigationLink(destination: ReservationsView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
            ) {
                Text("My Reservations")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
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
