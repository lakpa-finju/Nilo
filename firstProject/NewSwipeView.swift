//
//  NewSwipeView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct NewSwipeView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var name = ""
    @State private var numberOfSwipe = 0
    @State private var location = "Marketplace"
    @State private var time = ""
    @State private var message = ""
    
    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]
    
    var body: some View {
        VStack {
            textFieldsView
            Button {
                //add user
                let user = User(id: "W&L", name: name, location: location, numberOfSwipe: numberOfSwipe, time: time, message: message)
                userManager.addUser(user: user)
                
                
            } label: {
                Text("Save")
                    .foregroundColor(.black)
            }
            
        }
        
    }
    
    
    //This is the entire body view with text fileds and picker
    var textFieldsView: some View{
            VStack (alignment:.leading, spacing: 1){
                
                //For name
                HStack {
                    Text("Name: ").font(.system(.body)).foregroundColor(.black)
                    TextField("Enter your name here", text: $name)
                        .foregroundColor(.black)
                }
                
                
                //for location
                HStack {
                    Text("Location:").font(.system(.body)).foregroundColor(.black)
                    Picker("location", selection: $location) {
                        ForEach(locations, id:\.self){
                            Text($0)
                        }
                    }.foregroundColor(.black)
                }
                
                
                
                // for number of swipe
                HStack {
                    Text("Number of swipe:").font(.system(.body)).foregroundColor(.black)
                    Picker("numberOfSwipe", selection: $numberOfSwipe) {
                        ForEach(1..<21){ number in
                            Text("\(number)")
                        }
                    }.foregroundColor(.black)
                }
                
                
                
                //for time
                HStack{
                    Text("Time: ").font(.system(.body)).foregroundColor(.black)
                    TextField("when are you panning to eat", text: $time)
                }
                
                
                //for message
                HStack{
                    Text("Any message : ")
                        .font(.system(.body))
                        .foregroundColor(.black)
                    TextField("anything else (Optional)", text: $message)
                }
                
            }
    
        }

}

struct NewSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewSwipeView()
    }
}
