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
    @EnvironmentObject var eventManager: EventsManager 
    @Published var reservations: [Reservation] = []
    
    init() {
        let db = Firestore.firestore()
        _ = db.collection("Reservations").addSnapshotListener({ snapshot, error in
            guard (snapshot?.documents) != nil else{
                print("Error Fetching the Reservations \(error?.localizedDescription ?? "") from the databse")
                return
            }
            self.fetchReservations()
        })
        
    }
    //function to add resevations to the database
    func fetchReservations() {
        reservations.removeAll()
        let db = Firestore.firestore()
        db.collection("Reservations").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["Event Id"] as? String ?? ""
                    let reserverId = data["Reserver Id"] as? String ?? ""
                    let nameOfReserver = data["Name of reserver"] as? String ?? ""
                    let emailOfReserver = data["Email of Reserver"] as? String ?? ""
                    let eventOrganizerName = data["Event organizer name"] as? String ?? ""
                    
                    let reservation = Reservation(id: id,reserverId: reserverId, nameOfReserver: nameOfReserver, emailOfReserver: emailOfReserver, eventOrganizerName: eventOrganizerName)
                    self.reservations.append(reservation)
                }
            }
        }
    }

    
    
    //function to add resevations to the database
    private func addReservation(reservation: Reservation){
        let db = Firestore.firestore()
        let randomId = UUID.init().uuidString
        let ref = db.collection("Reservations").document(randomId)
        ref.setData(["Event Id":reservation.id,"Reserver Id":reservation.reserverId,"Name of reserver":reservation.nameOfReserver,"Email of Reserver":reservation.emailOfReserver, "Event organizer name": reservation.eventOrganizerName]){
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
        let reservation = Reservation(id: event.id,reserverId: self.geteUserId(), nameOfReserver: self.getUserName(), emailOfReserver: self.getUserEmail(), eventOrganizerName: event.name)
        //add reservation to the list to exchange between the view controller
        reservations.append(reservation)
        //add the reservation to the database
        self.addReservation(reservation: reservation)
        
        //updated event 
        let updatedEvent = Event(id: event.id, name: event.name, location: event.location, numberOfSwipes: event.numberOfSwipes-1, time: event.time, message: event.message, phoneNo: event.message, dateCreated: event.dateCreated, reserved: event.reserved+1)
        
        //update in the database
        let eventManager = EventsManager()
        eventManager.updateEvent(event: updatedEvent)
    }
}


