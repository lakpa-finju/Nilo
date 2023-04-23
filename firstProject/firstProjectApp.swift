//
//  firstProjectApp.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-16.
//

import SwiftUI
import Firebase


@main
struct firstProjectApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        
        WindowGroup {
            LoginView()
            
            //look into pod file for firebase
            
        }
    }
    
    
}
