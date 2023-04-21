//
//  ReservationManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI
import Firebase
import FirebaseAuth

class ReservationManager: ObservableObject{
    
    
    
    func reserveSpot() {
        guard Auth.auth().currentUser != nil else {
                return
            }
            /*
            // Create a new document in the 'reservations' collection with the user's ID as the document ID
            firestore.collection("reservations")
                .document(currentUser.uid)
                .setData([
                    "reservedBy": currentUser.uid,
                    "reservedAt": Timestamp()
                ])
             */
        }
        
        func cancelReservation() {
            guard Auth.auth().currentUser != nil else {
                return
            }
            /*
            // Delete the user's document from the 'reservations' collection
            firestore.collection("reservations")
                .document(currentUser.uid)
                .delete()
             */
        }
}
