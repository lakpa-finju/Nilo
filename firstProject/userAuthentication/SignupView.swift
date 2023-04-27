//
//  SignupView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI
import FirebaseAuth
struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var name = ""
    @StateObject private var eventManager = EventsManager()
    
    var body: some View {
            //if user is logged in send to locationView else sign in
            if userIsLoggedIn{
                LandingPageView()
                
            } else{
                //content
                content
            }
       
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
                
                //Name palceholder
                TextField("",text: $name)
                    .bold()
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Name", text: $name)
                
                //This is for line below Name
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //Email placeholder
                TextField("",text: $email)
                    .bold()
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Email", text: $email)
                //This is for line below emial
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                SecureField("", text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Password", text: $password)
                
                // this is for line below password
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //Creating Button for Sign up
                Button{
                    //sign up
                    register()
                } label: {
                    Text("Sign Up")
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
                .disabled(name.isEmpty || email.isEmpty || password.isEmpty)
                
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
    
    //sign up function
    func register(){
        /*
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error creating user: \(error!.localizedDescription)")
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name // user's name entered during sign up
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error setting user's display name: \(error.localizedDescription)")
                } else {
                    print("User's display name set successfully")
                }
            }
        }
        userIsLoggedIn.toggle()

         */
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error creating user: \(error!.localizedDescription)")
                return
            }
            userIsLoggedIn.toggle()
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name // user's name entered during sign up
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error setting user's display name: \(error.localizedDescription)")
                } else {
                    print("User's display name set successfully")
                }
            }
        }
        
        
    }


}



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

