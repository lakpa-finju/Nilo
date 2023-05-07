//
//  UserProfileManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
class UserProfilesManager: ObservableObject{
    
    //Update the user Email address once the accout has been created
    func updateUserEmail(newEmail: String) {
        if let user = Auth.auth().currentUser {
            user.updateEmail(to: newEmail) { error in
                if let error = error {
                    print("Error updating Email: \(error.localizedDescription)")
                    return
                } else {
                    print("Empail updated successfully!")
                }
            }
        } else {
            print("No user is currently signed in.")
        }    }
    
    //Update User Password
    func updateUserPassword(newPassword: String){
        if let user = Auth.auth().currentUser {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    print("Error updating password: \(error.localizedDescription)")
                    return
                } else {
                    print("Password updated successfully!")
                }
            }
        } else {
            print("No user is currently signed in.")
        }
    }

    // Update logged in user Name
    func updateUserName(newName: String){
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = newName
            changeRequest.commitChanges{
                error in
                if let error = error {
                    print("Error Updating Display name \(error.localizedDescription)")
                    return
                } else{
                    print("Display name updated successfully!")
                }
            }
            
        } else{
            print(("No User is currently Signed in"))
        }
    }

    // get the loggedin User name
    func getUserName() -> String{
        var name: String = "No Name"
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            name = user.displayName ?? "[Display name]"
            
        }
        return name
    }
    
    // get the loggedin User email
    func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    
    // get the loggedin user id
    func geteUserId() -> String{
        var userId: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            userId = user.uid
        }
        return userId
    }
    
    //add User Profile in the database for the firstime.
    func addUserProfile(userProfile: UserProfile){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userProfile.id)
        //let documentId = ref.documentID // This is generated by firebase
        ref.setData(["Id":userProfile.id,"Name": userProfile.name, "Relationship status": userProfile.relationshipStatus,"Email":userProfile.email, "Interests":userProfile.interests]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserDetails(userProfileId: String) async -> UserProfile? {
        do {
            let document = try await Firestore.firestore().collection("Users").document(userProfileId).getDocument()
            guard let userData = document.data() else {
                print("User data not found")
                return nil
            }
            let userProfile = UserProfile(
                id: document.documentID,
                name: userData["Name"] as? String ?? "",
                email: userData["Email"] as? String ?? "",
                relationshipStatus: userData["Relationship status"] as? String ?? "",
                interests: userData["Interests"] as? [String] ?? []
            )
            return userProfile
        } catch {
            print("Error getting user profile: \(error.localizedDescription)")
            return nil
        }
    }

    /*
    func getUserDetails(userProfileId: String) -> UserProfile {
        var requiredUserProfile: UserProfile = UserProfile(id: "test", name: "Test in UserProfile Manager", email: "test@test.userProfilemanager", relationshipStatus: "single", interests: [])
        let usersRef = Firestore.firestore().collection("Users").document(userProfileId)
        usersRef.getDocument { document, error in
            if let error = error {
                print("Error getting user profile: \(error.localizedDescription)")
                return
            }
            guard let document = document, document.exists else {
                print("Document doesn't exist")
                return
            }
            let userData = document.data()
            requiredUserProfile = UserProfile(
                id: document.documentID,
                name: userData?["Name"] as? String ?? "",
                email: userData?["Email"] as? String ?? "",
                relationshipStatus: userData?["Relationship status"] as? String ?? "",
                interests: userData?["Interests"] as? [String] ?? []
            )
            print(userData)
        }
        return requiredUserProfile
    }*/


    //function to logout the user
    func signOut() {
        do {
            try Auth.auth().signOut()

            // Set the root view controller to the login view controller
            let loginVC = LoginView()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: loginVC)
                window.makeKeyAndVisible()
            }

        } catch let error as NSError {
            print("Error signing out: %@", error)
        }
    }


    
}
