//
//  eventManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI
import Firebase
import FirebaseAuth
//importing foundation for time
//import Foundation

class EventManager: ObservableObject {
    @Published var events:[Event] = []
    
    init() {
        fetchEvents()
    }

    
    //function to get event from the database
    func fetchEvents(){
        events.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Events")
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
                    let numberOfSwipes = data["Number of swipes"] as? Int ?? 0
                    let time = data["Time"] as? String ?? ""
                    let message = data["Message"] as? String ?? ""
                    let phoneNo = data["PhoneNo"] as? String ?? ""
                    let dateCreated = data["createdTime"] as? Date ?? Date()
                    let reserved = data["reserved"] as? Int ?? 0
                    
                    let event = Event(id: id, name: name, location: location, numberOfSwipes: numberOfSwipes, time: time, message: message, phoneNo: phoneNo, dateCreated: dateCreated, reserved: reserved)
                    self.events.append(event)
                }
            }
        }
    }
    
    //function to get add event to the database
    func addevent(event: Event){
        let db = Firestore.firestore()
        let ref = db.collection("Events").document(event.name)
        ref.setData(["Id":event.id,"Name": event.name, "Location":event.location, "Number of swipes":event.numberOfSwipes, "Time": event.time, "Message": event.message, "PhoneNo": event.phoneNo, "createdTime": event.dateCreated, "Reserved":event.reserved]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    //returns a event given eventid
    func getevent(eventId: String) -> Event? {
        for event in self.events{
            if event.id == eventId{
                return event
            }
        }
        return nil
    }
    
    // get the loggedin event name
    func getUserName() -> String{
        var name: String = "No Name"
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            for info in user.multiFactor.enrolledFactors{
                name = info.displayName ?? "[DisplayName]"
            }
            
        }
        return name
    }
    
    // get the loggedin event email
    func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    
    // get the loggedin event id
    func geteUserId() -> String{
        var userId: String = ""
        //getting the loggedin event
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
