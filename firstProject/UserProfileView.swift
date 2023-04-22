//
//  UserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI
struct UserProfileView: View {
    @EnvironmentObject var eventManger: EventManager
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

            Text(eventManger.getUserName())
                .font(.title)
            
            NavigationLink(destination: ChangeEmailView()) {
                Text("Change Email")
                    .foregroundColor(.blue)
            }
            
            NavigationLink(destination: ChangePasswordView()) {
                Text("Change Password")
                    .foregroundColor(.blue)
            }
            
            NavigationLink(destination: ReservationsView()) {
                Text("My Reservations")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Profile")
    }
}

struct ChangeEmailView: View {
    var body: some View {
        Text("Change Email")
    }
}

struct ChangePasswordView: View {
    var body: some View {
        Text("Change Password")
    }
}

struct ReservationsView: View {
    var body: some View {
        Text("My Reservations")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(EventManager())
    }
}
