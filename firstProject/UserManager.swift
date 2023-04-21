//
//  UserManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI
import Firebase
import FirebaseAuth
//importing foundation for time
//import Foundation

class UserManager: ObservableObject {
    @Published var users:[User] = []
    
    init() {
        fetchUsers()
    }

    
    //function to get user from the database
    func fetchUsers(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    let id = data["Id"] as? String ?? ""
                    let name = data["Name"] as? String ?? ""
                    let location = data["Location"] as? String ?? ""
                    let numberOfSwipe = data["Number of swipes"] as? Int ?? 0
                    let time = data["Time"] as? String ?? ""
                    let message = data["Message"] as? String ?? ""
                    let phoneNo = data["PhoneNo"] as? String ?? ""
                    let dateCreated = data["Date created"] as? Date ?? Date()
                    
                    let user = User(id: id, name: name, location: location, numberOfSwipes: numberOfSwipe, time: time , message: message , phoneNo: phoneNo , dateCreated: dateCreated )
                    self.users.append(user)
                }
            }
        }
    }
    
    //function to get add user to the database
    func addUser(user: User){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(user.name)
        ref.setData(["Id":user.id,"Name": user.name, "Location":user.location, "Number of swipes":user.numberOfSwipes, "Time": user.time, "Message": user.message, "PhoneNo": user.phoneNo, "Date created": user.dateCreated]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    // get the loggedin user name
    func getUserName() -> String{
        var name: String = "No Name"
        //getting the loggedin User
        let user = Auth.auth().currentUser
        if let user = user {
            for info in user.multiFactor.enrolledFactors{
                name = info.displayName ?? "[DisplayName]"
            }
            
        }
        return name
    }
    
    // get the loggedin user email
    func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin User
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    
    // get the loggedin user id
    func getUserId() -> String{
        var userId: String = ""
        //getting the loggedin User
        let user = Auth.auth().currentUser
        if let user = user {
            userId = user.uid 
        }
        return userId
    }
    
    //get time for record added.
    func getTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm:ss a zzz"
        let stringTime = dateFormatter.string(from: Date()) // Example output: "April 21, 2023 at 1:47:30 PM UTC-04:00"
        guard let time = dateFormatter.date(from: stringTime) else { return Date() }
        return time
        
    }
    
     
   
    
}
