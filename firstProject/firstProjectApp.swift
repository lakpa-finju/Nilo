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
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
      
     WindowGroup {
         ListView().environmentObject(dataManager)
            /*NavigationStack{
                //RootView()
            }*/
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
