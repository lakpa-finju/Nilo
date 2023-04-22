//
//  UserProfileView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-21.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userManager: EventManager
    @State var reservations:[String:Any]
    var body: some View {
       
        Text("You are authenic")
      
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView( reservations: ["dog" : Event.self]).environmentObject(EventManager())
    }
}
