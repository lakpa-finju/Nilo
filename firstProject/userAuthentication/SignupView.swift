//
//  SignupView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI
import FirebaseAuth
struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var name = ""
    @StateObject private var eventManager = EventsManager()
    @EnvironmentObject private var userProfilesManager : UserProfilesManager
    @State private var userIsVerified = false
    
    var body: some View {
        //if user is logged in send to locationView else sign in
        //may be implement isVarified option for email verification when creating a new user for the first time.
        if (userIsLoggedIn && userIsVerified){
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
                .foregroundStyle(.linearGradient(colors: [.cyan,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    .customPlaceholder("Full Name", text: $name)
                
                //This is for line below name
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //Email placeholder
                TextField("",text: $email)
                    .bold()
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .customPlaceholder("Email", text: $email)
                
                //This is for line below email
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //For password
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
                    Task{
                        await register()
                        name = ""
                        email = ""
                        password = ""
                    }
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
                        //userIsLoggedIn = true
                        //userisVerified = true
                    }
                }
            }
            
        }.ignoresSafeArea()
    }
    
    func register() async {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            try await changeRequest.commitChanges()
                        
            try await user.sendEmailVerification()
            userIsVerified = user.isEmailVerified
            print("Verification email sent to \(email)")
            let alert = UIAlertController(title: "Verify your email", message: "A verification email has been sent to \(email). Please check your inbox and follow the instructions to verify your account.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if user.isEmailVerified{
                    userIsLoggedIn = true
                    userIsVerified = true
                }
                self.presentationMode.wrappedValue.dismiss()
                
            }))
            
            if let viewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            } else {
                print("Error: no key window available")
            }
        } catch {
            print("Error creating user: \(error.localizedDescription)")
        }
    }
    
}



struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(UserProfilesManager())
    }
}

