//
//  UserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var eventManger: EventsManager
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @EnvironmentObject var reservationsManager: ReservationsManager
    @EnvironmentObject var profileImagesManager: ProfileImagesManager
    @State private var profileImage: UIImage?
    
    var body: some View {
        VStack(spacing: 6) {
            if let profileImage = profileImagesManager.loadProfileImage(profileImageId: eventManger.geteUserId()){
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150,height: 200)
                    .clipShape(Circle())
    
            } else{
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
               
            //Display Name and Email address right below profile picture
            Text(userProfileManager.getUserName())
                .font(.title)
            Text(userProfileManager.getUserEmail())
                .font(.body)
            
            //Upload/change Profile Picture
            NavigationLink(destination: ProfileImageUploadView()
                .environmentObject(userProfileManager)
                .environmentObject(profileImagesManager)) {
                Text("Change/upload profile Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)            }

            
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
            
            //list of swipes taken
            NavigationLink(destination: AttendeesRoasterView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
                .environmentObject(profileImagesManager)
            ) {
                Text("Swipe(s) reserved")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            //list of reservations that the logged in User made
            NavigationLink(destination: ReservationsView()
                .environmentObject(userProfileManager)
                .environmentObject(reservationsManager)
                .environmentObject(profileImagesManager)
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
        .onAppear{
            profileImage = profileImagesManager.loadProfileImage(profileImageId: userProfileManager.geteUserId())
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
        
    }
}
