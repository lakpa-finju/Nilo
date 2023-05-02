//
//  UserProfile.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-30.
//

class UserProfile {
    var id: String
    var name: String
    var email: String
    var interests: [String]
    
    init(id: String, name: String, email: String, interests: [String]) {
        self.id = id
        self.name = name
        self.email = email
        self.interests = interests
    }
}
