//
//  ForgotPasswordView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-30.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @State private var email = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send Password Reset Email") {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        print("Error sending password reset email: \(error.localizedDescription)")
                    } else {
                        print("Password reset email sent to \(email)")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 20)
        }
        .padding()
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

