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
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dataManager = DataManager()
    @StateObject var eventManager = EventManager()
    @StateObject var reservationsManager = ReservationsManager()
    @StateObject var userProfileManager = UserProfilesManager()
    

    
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        
        WindowGroup {
            //RootView()
            LoginView()
                .environmentObject(eventManager)
              .environmentObject(reservationsManager)
              .environmentObject(userProfileManager)
            //ContentView()
            //ListView().environmentObject(dataManager)
            
            //todo
            //Reserve button and update isn't workign properly
            
            
        }
    }
    
    
}
/*
 class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication,
 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
 FirebaseApp.configure()
 print("Configured Firebase")
 return true
 }
 }
 */
