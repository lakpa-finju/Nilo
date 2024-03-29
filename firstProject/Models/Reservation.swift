//
//  Reservation.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI

struct Reservation: Identifiable{
    var id: String // Id of the event
    var eventId:String
    var reserverId:String
    var nameOfReserver:String
    var emailOfReserver:String
    var eventOrganizerName:String
    var eventOrganizerEmail:String
    var eventTime:Date
    
}

