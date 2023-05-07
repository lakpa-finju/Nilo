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
    @Environment(\.presentationMode) var presentationMode
    @State private var profileImage: UIImage?
    @State private var isShowingSettings = false
    
    var body: some View {
        VStack(spacing: 6) {
            if let profileImage = profileImagesManager.loadProfileImage(profileImageId: eventManger.geteUserId()){
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 150,maxHeight: 200)
                    .clipShape(Circle())
                
            } else{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
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
            
            Spacer()
                        
        }
        .padding()
        .navigationBarTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button{
                    isShowingSettings.toggle()
                }label:{
                    Image(systemName:"gear" )//"line.horizontal.3")
                }
            })
                        }
                        
        .onAppear{
            profileImage = profileImagesManager.loadProfileImage(profileImageId: userProfileManager.geteUserId())
        }
        .sheet(isPresented: $isShowingSettings) {
            NavigationView {
                List {
                    //Upload/change Profile Picture
                    NavigationLink(destination: ProfileImageUploadView()
                        .environmentObject(userProfileManager)
                        .environmentObject(profileImagesManager)) {
                            Label("Change/Upload profile Image", systemImage: "person.crop.circle")
                            
                        }
                    
                    
                    //upate Name
                    NavigationLink(destination: UpdateUserNameView()
                        .environmentObject(userProfileManager)) {
                            Label("Change Name", systemImage: "pencil.and.ellipsis.rectangle")           }
                    
                    
                    //upate email
                    NavigationLink(destination: UpdateEmailView()
                        .environmentObject(userProfileManager)) {
                            Label("Update Email", systemImage: "envelope")                        }
                    
                    //update Password
                    NavigationLink(destination: UpdatePasswordView()
                        .environmentObject(userProfileManager)
                                   
                    ) {
                        Label("Change Password", systemImage: "lock.rotation")
                    }
                    
                    Button(action: {
                        userProfileManager.signOut()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Sign out", systemImage: "power")
                         
                    }
                }
                .navigationTitle("Settings")
            }
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
        
    }
}
