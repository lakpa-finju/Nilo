//
//  UserManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI
import Firebase
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
                    let id = document.documentID
                    let name = data["Name"] as? String ?? ""
                    let location = data["Location"] as? String ?? ""
                    let numberOfSwipe = data["Number of swipe"] as? Int ?? 0
                    let time = data["Time"]
                    let message = data["Message"]
                    
                    let user = User(id: id, name: name, location: location, numberOfSwipe: numberOfSwipe, time: time as! String, message: message as! String)
                    self.users.append(user)
                }
            }
        }
    }
    
    //function to get add user to the database
    func addUser(user: User){
        //creating a short date fromatter i.e 12/10/21 5:00 pm
        /*let date = Date()
        let df = DateFormatter()
        df.dateStyle = DateFormatter.Style.medium
        df.timeStyle = DateFormatter.Style.short
         let time = df.string(from: date) //this is not tested
        */
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(user.name)
        ref.setData(["Name": user.name, "Location":user.location, "Number of swipe":user.numberOfSwipe, "Time": user.time, "Message": user.message]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
