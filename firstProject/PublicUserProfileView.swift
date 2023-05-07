//
//  PublicUserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-05-01.
//

import SwiftUI

struct PublicUserProfileView: View {
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @EnvironmentObject var profileImagesManager: ProfileImagesManager
    @State private var profileImage: UIImage?
    @State var userProfileId: String?
    var userProfile: UserProfile
    
    
    var body: some View {
        VStack(spacing: 6) {
            if let profileImage = profileImagesManager.loadProfileImage(profileImageId: userProfile.id){
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
            
            VStack(spacing: 8) {
                Text(userProfile.name)
                    .font(.title)
                    .foregroundColor(.primary)
                Text(userProfile.email)
                    .font(.system(.body))
                    .foregroundColor(.primary)
                if !userProfile.relationshipStatus.isEmpty{
                    if userProfile.relationshipStatus.lowercased() == "single"{
                        Text(userProfile.relationshipStatus)
                            .font(.title3)
                            .foregroundColor(.primary)
                            .background(Color.green)
                            .cornerRadius(5)
                    }else{
                        Text(userProfile.relationshipStatus)
                            .font(.title3)
                            .foregroundColor(.primary)
                            .background(Color(red: 1.0, green: 0.84, blue: 0.0)) // to represent someone is taken
                            .cornerRadius(5)
                    }
                }
                
            }
            if !userProfile.interests.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    VStack{
                        Text("Interests")
                            .underline()
                            .font(.title3)
                            .foregroundColor(.primary)
                        ForEach(userProfile.interests, id: \.self) { interest in
                            Text(interest)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    
                }
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle("Profile")
    }
}

struct PublicUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let userProfile = UserProfile(id: "23232", name: "lakpa", email: "lakpa@mail.com",relationshipStatus: "Single", interests: ["running","basketball"])
        PublicUserProfileView(userProfile: userProfile)
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
    }
}
