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
    @StateObject private var userManager = UserManager()
    
    var body: some View {
            //if user is logged in send to locationView else sign in
            if userIsLoggedIn{
                LocationView().environmentObject(userManager)
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
                TextField("Email",text: $email)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("Email")
                            .foregroundColor(.black)
                            .bold()
                    }
                //This is for line below emial
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                SecureField("Password",text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty){
                        Text("Password")
                            .foregroundColor(.black)
                            .bold()
                    }
                // this is for line below password
                Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.black)
                
                //Creating Button for Sign up
                Button{
                    //sign in
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
                
            }
            .frame(width: 350)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
            
        }.ignoresSafeArea()
    }
    
    //sign up function
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)//force unwrapping cos we checked if it is nill
            }
            userIsLoggedIn.toggle()
        }
    }


}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
