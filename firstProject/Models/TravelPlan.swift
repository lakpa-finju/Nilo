//
//  TravelPlan.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//
import Foundation

struct TravelPlan: Identifiable{
    var id: String
    var publisherId: String
    var publisherName: String
    var phoneNo: String
    var from: String
    var to: String
    var hasCar: Bool
    var travelDate:Date
    var message:String
    
}
