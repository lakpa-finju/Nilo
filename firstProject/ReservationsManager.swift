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
    
    private func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    func reserveSpot(for event: Event) {
        // Check if there are any available spots
        guard event.numberOfSwipes > 0 else { return }
        
        /*let updatedEvent = Event(id:event.id,name: event.name, location:event.location, numberOfSwipes: event.numberOfSwipes - 1, time:event.time, message: event.message, phoneNo: event.phoneNo, dateCreated: event.dateCreated, reserved:event.reserved + 1)*/
        
        // Create a new reservation object and add it to the reservations array
        let reservation = Reservation(id: event.id, email: self.getUserEmail())
        reservations.append(reservation)
        
        
        // Update the event in Firestore
        Firestore.firestore().collection("Events").document(event.name).setData(["Id":event.id,"Name": event.name, "Location":event.location, "Number of swipes":event.numberOfSwipes - 1, "Time": event.time, "Message": event.message, "PhoneNo": event.phoneNo, "createdTime": event.dateCreated, "Reserved":event.reserved + 1]) { error in
            if let error = error {
                print("Error updating event: \(error.localizedDescription)")
            } else {
                print("Event updated successfully.")
            }
        }
    }
}


/*
 
 //creates a dictionary with userId to user object
 @Published var reservationLists:[String:Event] = [:]
 
 func fetchReservation(){
 reservationLists.removeAll()
 
 }
 
 
 //function to reserve spot
 func reserveSpot(user: Event) {
 self.reservationLists[user.id] = user
 
 }
 
 // Function to cancel reservatino
 func cancelReservation(user:Event) {
 self.reservationLists.removeValue(forKey: user.id)
 }
 */

