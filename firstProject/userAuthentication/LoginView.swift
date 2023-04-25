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
                .foregroundStyle(.linearGradient(colors: [.white,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y:-35)
            VStack{
                Text("Welcome")
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .bold,design: .rounded))
                    .offset(x:-100,y: -100)
                TextField("",text: $email)
                    .bold()
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Email", text: $email)

                //This is for line below emial
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                SecureField("",text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Password", text: $password)
                // this is for line below password
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //Creating Button for Sign up
                Button{
                    //sign in
                    login()
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))
                        )
                }
                .padding(.top)
                .offset(y:100)
                .disabled(email.isEmpty || password.isEmpty)
                
                //create a navigation link to go to singupView
                NavigationLink{
                    SignupView()
                }label: {
                    Text("Do not have an account? Sign up")
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(.top)
                .offset(y: 110)
                
                
            }
            .frame(width: 350)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                       //userIsLoggedIn.toggle()
                    }
                }
            }
            
        }.ignoresSafeArea()
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


