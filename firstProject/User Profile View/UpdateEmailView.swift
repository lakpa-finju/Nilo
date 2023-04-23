//
//  ChangeEmailView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//

import SwiftUI

struct UpdateEmailView: View {
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @State private var newEmail: String = ""

    var body: some View {
        VStack {
            TextField("New Email Address", text: $newEmail)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    
            Button{
                userProfileManager.updateUserEmail(newEmail: newEmail)
                newEmail = ""
            } label: {
                        Text("Update Email")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                
                }
                .padding()
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailView().environmentObject(UserProfilesManager())
    }
}
