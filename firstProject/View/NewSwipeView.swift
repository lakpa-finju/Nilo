//
//  NewSwipeView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct NewSwipeView: View {
    @EnvironmentObject var eventManager: EventManager
    @State private var name = ""
    @State private var numberOfSwipes = 1
    @State private var location = "Marketplace"
    @State private var time = ""
    @State private var message = ""
    @State private var phoneNo = ""
    @State private var isSaved = false
    
    
    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]
    
    var body: some View {
        
        VStack {
            Text("Offer Swipe")
                .font(.system(.title))
                .bold()
                .offset(y:-20)

            textFieldsView
            
            Button {
                //add user
                let event = Event(id: "EventManagerclass", name: name, location: location, numberOfSwipes: numberOfSwipes, time: time, message: message, phoneNo: phoneNo, dateCreated: eventManager.getTime(), reserved: 0)
                                
                //adding user to the database
                eventManager.addevent(event: event)
                
                //Reset state variables
                //name = ""
                numberOfSwipes = 1
                location = "Marketplace"
                time = ""
                message = ""
                phoneNo = ""
                isSaved.toggle() //alters the boolean variable value
                
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(50)
                    .padding(.horizontal)
                
            }
            .padding()
            .disabled(time.isEmpty)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        
        
    }
    
    
    //This is the entire body view with text fileds and picker
    var textFieldsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            //For name
            HStack {
                Text("Name")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                TextField("Enter your name here", text: $name)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            //for location
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                Picker("Location", selection: $location) {
                    ForEach(locations, id:\.self) {
                        Text($0)
                    }
                }
                .font(.system(size: 18))
                .foregroundColor(.black)
            }
            
            //for swipes
            HStack {
                Text("Number of swipes")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                Picker("Number of swipes", selection: $numberOfSwipes) {
                    ForEach(0..<21) { number in
                        Text("\(number)")
                    }
                }
                .font(.system(size: 18))
                .foregroundColor(.white)
            }
            
            //for time
            HStack {
                Text("Time")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                TextField("When are you planning to eat", text: $time)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            
            //for message
            HStack {
                Text("Message")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                TextField("Anything else (Optional)", text: $message)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            //for Phone Number
            HStack {
                Text("Phone no")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 80, alignment: .leading)
                
                TextField("Contact Number (Optional)", text: $phoneNo)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
        
    }
    
}

struct NewSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewSwipeView().environmentObject(EventManager())
    }
}
