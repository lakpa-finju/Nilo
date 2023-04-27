//
//  LoginView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-19.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    
    var body: some View {
        NavigationStack{
            //if user is logged in the send to locationView else login
            if userIsLoggedIn{
                //ListView().environmentObject(dataManager)
                LocationView()
                
            } else{
                //content
                content
            }
            //LocationView().environmentObject(userManager)
        }.accentColor(Color(.label))
            
        
        
    }
    
    var content: some View{
        ZStack{
            Color.white
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue,.mint], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .rotationEffect(.degrees(60))
            VStack{
                Text("Welcome")
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .bold,design: .rounded))
                    .padding(.top, 20)

                TextField("",text: $email)
                    .bold()
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Email", text: $email)
                    .padding(.horizontal, 20)

                //This is for line below emial
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                SecureField("",text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Password", text: $password)
                    .padding(.horizontal, 20)
                // this is for line below password
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                //Creating Button for Sign up
                Button{
                    //sign in
                    login()
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(maxWidth: 200, minHeight: 40)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))
                        )
                }
                .padding(.top, 20)
                .disabled(email.isEmpty || password.isEmpty)
                
                //create a navigation link to go to singupView
                NavigationLink{
                    SignupView()
                }label: {
                    Text("Do not have an account? Sign up")
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(.top, 10)
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                       //userIsLoggedIn.toggle()
                    }
                }
            }
            
        }
        .ignoresSafeArea()
    }
    //log in
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
            guard  authResult?.user != nil, error == nil else {
                print("Error creating user: \(error!.localizedDescription)")
                return
            }
            userIsLoggedIn.toggle()
        }
    }
    

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


