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
