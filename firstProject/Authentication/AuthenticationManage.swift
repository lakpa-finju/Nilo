//
//  AuthenticationManage.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-17.
//

import Foundation
import FirebaseAuth
//local Data model
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user:User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager{
    
    static let shared = AuthenticationManager()
    private init(){ }
    
    //Get a already signed in user
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse) // this is lazy error need to check in the future.
        }
        
        return AuthDataResultModel(user: user)
    }
    
    //Sing in new suer
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user:authDataResult.user)
    }
    
    
    //sing out func
    func singOut() throws {
        try Auth.auth().signOut()
    }
   
}
