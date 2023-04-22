//
//  ReservationManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI
import Firebase
import FirebaseAuth

class ReservationsManager: ObservableObject{
    @EnvironmentObject var eventManager: EventManager 
    @Published var reservations: [Reservation] = []
    
    //function to add resevations to the database
    private func addReservation(reservation: Reservation){
        let db = Firestore.firestore()
        let ref = db.collection("Reservations").document(reservation.id)
                ref.setData(["id":reservation.id,"Name":reservation.NameOfReserver,"Email":reservation.email]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    //get the loggedin user Email
    private func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    
    // get the loggedin event name
    private func getUserName() -> String{
        var name: String = "No Name"
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            name = user.displayName ??  "[Display Name]"
            
        }
        return name
    }
    
    // get the loggedin event id
    private func geteUserId() -> String{
        var userId: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            userId = user.uid
        }
        return userId
    }
    
    //Function to reserve a spot
    func reserveSpot(for event: Event) {
        // Check if there are any available spots
        guard event.numberOfSwipes > 0 else { return }
                
        // Create a new reservation object and add it to the reservations array
        let reservation = Reservation(id: self.geteUserId(),NameOfReserver: self.getUserName(), email: self.getUserEmail())
        //add reservation to the list to exchange between the view controller
        reservations.append(reservation)
        //add the reservation to the database
        self.addReservation(reservation: reservation)
        
        //updated event 
        let updatedEvent = Event(id: event.id, name: event.name, location: event.location, numberOfSwipes: event.numberOfSwipes-1, time: event.time, message: event.message, phoneNo: event.message, dateCreated: event.dateCreated, reserved: event.reserved+1)
        
        //update in the database
        let eventManager = EventManager()
        eventManager.updateEvent(event: updatedEvent)
    }
}


