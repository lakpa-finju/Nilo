//
//  ChangePasswordView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//

import SwiftUI

struct UpdatePasswordView: View {
    @EnvironmentObject var userProfileManager: UserProfilesManager
    @State private var newPassword: String = ""

    var body: some View {
        VStack {
            SecureField("Enter a new Password", text: $newPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    
            Button{
                userProfileManager.updateUserPassword(newPassword: newPassword)
                newPassword = ""
            } label: {
                        Text("Update password")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                
                }
                .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
            .environmentObject(UserProfilesManager())
    }
}
