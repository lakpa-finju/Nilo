//
//  SignInEmailView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-17.
//

import SwiftUI
final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    
}


struct SignInEmailView: View {
    @State private var viewModel = SignInEmailViewModel()
    var body: some View {
        VStack{
            //THis is Email field
            TextField("Email..", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            //This is for password fireld
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button{
                
            }label: {
                Text("Sing In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInEmailView()
        }
    }
}
