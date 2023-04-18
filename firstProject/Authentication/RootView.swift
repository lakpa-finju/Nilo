//
//  RootView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-17.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSigInView: Bool = false
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignInView: $showSigInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSigInView = authUser == nil 
        }
        .fullScreenCover(isPresented: $showSigInView){
            NavigationStack{
                AuthenticationView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
