//
//  UserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI
struct UserProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            
            Text("John Doe")
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
        UserProfileView()
    }
}
