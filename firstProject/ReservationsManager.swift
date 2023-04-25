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
    //@EnvironmentObject var eventManager: EventsManager
    @Published var reservations: [String:Reservation] = [:]
    
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
    
    //function to fetch resevations from the database
    func fetchReservations() {
        reservations.removeAll()
        let db = Firestore.firestore()
        db.collection("Reservations").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["Id"] as? String ?? ""
                    let eventId = data["Event Id"] as? String ?? ""
                    let reserverId = data["Reserver Id"] as? String ?? ""
                    let nameOfReserver = data["Name of reserver"] as? String ?? ""
                    let emailOfReserver = data["Email of Reserver"] as? String ?? ""
                    let eventOrganizerName = data["Event organizer name"] as? String ?? ""
                    let eventOrganizerEmail = data["Event organizer email"] as? String ?? ""
                    let eventTime = data["Event time"] as? String ?? ""
                    
                    
                    let reservation = Reservation(id: id,eventId: eventId,reserverId: reserverId, nameOfReserver: nameOfReserver, emailOfReserver: emailOfReserver, eventOrganizerName: eventOrganizerName, eventOrganizerEmail: eventOrganizerEmail, eventTime: eventTime)
                    self.reservations[id] = reservation
                    
                }
            }
        }
    }
    
    
    
    //function to add resevations to the database
    private func addReservation(reservation: Reservation){
        let db = Firestore.firestore()
        let ref = db.collection("Reservations").document(reservation.id)
        ref.setData(["Id":reservation.id,"Event Id":reservation.eventId,"Reserver Id":reservation.reserverId,"Name of reserver":reservation.nameOfReserver,"Email of Reserver":reservation.emailOfReserver, "Event organizer name": reservation.eventOrganizerName,"Event organizer email":reservation.eventOrganizerEmail,"Event time":reservation.eventTime]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    //function to check if a document is in the database collections
    func checkExistence(collectionsName: String, documentId: String) async -> Bool {
        let db = Firestore.firestore()
        let documentReference = db.collection(collectionsName).document(documentId)
        do {
            let documentSnapshot = try await documentReference.getDocument()
            return documentSnapshot.exists
        } catch {
            print("Error fetching document: \(error)")
            return false
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
        let randomId = UUID.init().uuidString
        let reservation = Reservation(id: randomId, eventId: event.id, reserverId: self.geteUserId(), nameOfReserver: self.getUserName(), emailOfReserver: self.getUserEmail(), eventOrganizerName: event.name, eventOrganizerEmail: event.email, eventTime: event.time)
        
        //add reservation to the list to exchange between the view controller
        self.reservations[reservation.id] = reservation
        //add the reservation to the database
        self.addReservation(reservation: reservation)
        
        //updated event
        let updatedEvent = Event(id: event.id, name: event.name,email: event.email , location: event.location, numberOfSwipes: event.numberOfSwipes-1, time: event.time, message: event.message, phoneNo: event.message, dateCreated: event.dateCreated, reserved: event.reserved+1)
        
        //get the profile image of the event organizer from the database
        /*let profileImagesManager = ProfileImagesManager()
         profileImagesManager.loadEventOrganizerImage(profileImageId: reservation.eventId)*/
        
        //update in the database
        let eventManager = EventsManager()
        eventManager.updateEvent(event: updatedEvent)
    }
    
    ///Function to cancel a spot
    func cancelSpot(for reservation: Reservation) {
        guard reservations[reservation.id] != nil else {
            return
        }
        //if there is reservation then remove it from reservations and update the event
        reservations[reservation.id] = nil
        
        //delete the reservation from the database
        self.deleteReservation(reservation: reservation)
        
        //get the profile image of the event organizer from the database
        /*let profileImagesManager = ProfileImagesManager()
         profileImagesManager.loadEventOrganizerImage(profileImageId: reservation.eventId)*/
        
        //update in the database
        let eventManager = EventsManager()
        //Update the event's number of swipe
        let event = eventManager.getevent(eventId: reservation.eventId)
        //updated event
        guard var event = event else{
            return
        }
        let updatedEvent = Event(id: event.id, name: event.name, email: event.email, location: event.location, numberOfSwipes: event.numberOfSwipes+1, time: event.time, message: event.message, phoneNo: event.phoneNo, dateCreated: event.dateCreated, reserved: event.reserved-1)

        eventManager.updateEvent(event: updatedEvent)
    }
    
    
    //function to delete event from the database
    func deleteReservation(reservation: Reservation){
        let db = Firestore.firestore()
        let ref = db.collection("Reservations").document(reservation.id)
        // Delete the document
        ref.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
        
    }
    
}


