//
//  UpdateUserNameView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//

import SwiftUI

struct UpdateUserNameView: View {
    @EnvironmentObject var userProfileManager: UserProfileManager
    @State private var firstName: String = ""
    @State private var lastName: String = ""

    var body: some View {
        VStack {
            HStack{
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
            }
                Button{
                    userProfileManager.updateUserName(newName: firstName+" "+lastName)
                    firstName = ""
                    lastName = ""
                } label: {
                    Text("Update Name")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                
            }
                
                }
                .padding()
    }
}

struct UpdateUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserNameView()
            .environmentObject(UserProfileManager())
    }
}
