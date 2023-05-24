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
    @Published var eventIdToReservationId:[String:String] = [:]
    // This is for the user's reservation to other people events
    @Published var personalizedReservation:[String:Reservation] = [:] // This is just for the user's reservation
    // This is for other people's reservation to the user's event
    @Published var peopleReservation:[String:Reservation] = [:]
    init() {
        let db = Firestore.firestore()
        _ = db.collection("Reservations").addSnapshotListener({ snapshot, error in
            guard (snapshot?.documents) != nil else{
                print("Error Fetching the Reservations \(error?.localizedDescription ?? "") from the databse")
                return
            }
            self.fetchReservations()
        })
        //listen to the changes in the event collections as well
        _ = db.collection("Events").addSnapshotListener({ snapshot, error in
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
        eventIdToReservationId.removeAll()
        personalizedReservation.removeAll()
        peopleReservation.removeAll()
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
                    let timeStamp = data["Event time"] as? Timestamp ?? Timestamp()
                    let eventTime = timeStamp.dateValue()
                    
                    
                    let reservation = Reservation(id: id,eventId: eventId,reserverId: reserverId, nameOfReserver: nameOfReserver, emailOfReserver: emailOfReserver, eventOrganizerName: eventOrganizerName, eventOrganizerEmail: eventOrganizerEmail, eventTime: eventTime)
                    if eventTime < Date(){
                        self.addReservationToHistory(reservation: reservation)
                        self.deleteReservation(reservation: reservation)
                    }
                    self.reservations[id] = reservation
                    self.eventIdToReservationId[eventId] = id
                    // this will collect the respective user's reservations
                    if (reserverId == self.geteUserId()){
                        self.personalizedReservation[reservation.id] = reservation // this will collect the respective user's reservations
                    }
                    // this will collect the people reservation to the user's event
                    if (eventId == self.geteUserId()){
                        self.peopleReservation[id] = reservation
                    }
                    
                    
                    
                    
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
    
    //function to add resevations to the database in the history collection as the reservation passes the current date
    private func addReservationToHistory(reservation: Reservation){
        let db = Firestore.firestore()
        let ref = db.collection("ReservationsHistory").document(reservation.id)
        ref.setData(["Id":reservation.id,"Event Id":reservation.eventId,"Reserver Id":reservation.reserverId,"Name of reserver":reservation.nameOfReserver,"Email of Reserver":reservation.emailOfReserver, "Event organizer name": reservation.eventOrganizerName,"Event organizer email":reservation.eventOrganizerEmail,"Event time":reservation.eventTime]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
    }
    
    //Function to check existence locally in the cache memory
    func checkExistence(reservationId:String)->Bool{
        guard reservations[reservationId] != nil else {
            return false
        }
        return true
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
        
        //add reservation to the dictionary to exchange between the view controller
        self.reservations[reservation.id] = reservation
        //add the reservation to the database
        self.addReservation(reservation: reservation)
        //adding to the collection of personalized reservtion
        if (reservation.reserverId == self.geteUserId()){
            personalizedReservation[reservation.id] = reservation // this will collect the respective user's reservations
        }
        
        //update in the database
        let eventManager = EventsManager()
        eventManager.updateEvent(eventId: event.id)
    }
    
    ///Function to cancel a spot
    func cancelSpot(for reservation: Reservation) {
        guard reservations[reservation.id] != nil else {
            return
        }
        //if there is reservation then remove it from reservations and update the event
        reservations[reservation.id] = nil // this will not throw or return any error even if there is no value associated with it.
        //also remove it form the personalizes reservation dictionary
        personalizedReservation[reservation.id] = nil

        //delete the reservation from the database
        self.deleteReservation(reservation: reservation)
        
        //get the profile image of the event organizer from the database
        /*let profileImagesManager = ProfileImagesManager()
         profileImagesManager.loadEventOrganizerImage(profileImageId: reservation.eventId)*/
        
        let db = Firestore.firestore()
        let ref = db.collection("Events").document(reservation.eventId)
        ref.updateData([
            "Number of swipes": FieldValue.increment(Int64(1)),
            "Reserved": FieldValue.increment(Int64(-1))
        ]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully")
            }
        }


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
    
    //function to delete reservation from the database using condition
    func deleteReservationsWithCondition(eventId: String) {
        let db = Firestore.firestore() // Initialize Firestore
        
        let collectionRef = db.collection("Reservations") // Replace "your_collection" with the actual collection name
        
        // Build the query
        let query = collectionRef.whereField("Event Id", isEqualTo: eventId) // Replace "field" and "value" with the actual field and value you want to query
        
        // Execute the query
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            // Delete documents that match the query condition
            for document in querySnapshot!.documents {
                document.reference.delete { error in
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        print("Document deleted successfully")
                    }
                }
            }
        }
    }

    
    //function to delete event from the database
    func deleteReservation(reservationId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Reservations").document(reservationId)
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


