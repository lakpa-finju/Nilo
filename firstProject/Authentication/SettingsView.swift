//
//  SettingsView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-17.
//

import SwiftUI
@MainActor
final class SettingsViewModel: ObservableObject{
    
    func singOut() throws {
        try AuthenticationManager.shared.singOut()
    }
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do{
                        try viewModel.singOut()
                        
                    }catch{
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false)) // need to handle the binding show sinnInView variale. 
        }
        
    }
}
