//
//  SwipePlanFormView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-28.
//
import SwiftUI
struct NewSwipeView: View {
    @EnvironmentObject private var eventsManager: EventsManager
    //@State private var name = ""
    @State private var numberOfSwipes = 1
    @State private var location = "Marketplace"
    @State private var date = Date()
    @State private var message = ""
    @State private var phoneNo = ""

    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]

    var body: some View {
            Form {
                Section(header: Text("Swipe information")) {
                  //  TextField("Name", text: $name)
                    Stepper(value: $numberOfSwipes, in: 1...20) {
                        Text("Number of Swipes: \(numberOfSwipes)")
                    }
                    Picker("Location", selection: $location) {
                        ForEach(locations, id: \.self) {
                            Text($0)
                        }
                    }
                    DatePicker(selection: $date, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                        Text("Date")
                    }
                }

                Section(header: Text("Additional Information")) {
                    TextField("Message (Optional)", text: $message)
                    TextField("Phone Number (Optional)", text: $phoneNo)
                }
            }
            .navigationTitle("Offer Swipe(s)")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        //add user
                        let event = Event(id: eventsManager.geteUserId(), name: eventsManager.getUserName(),email: eventsManager.getUserEmail(), location: location, numberOfSwipes: numberOfSwipes, time: date, message: message, phoneNo: phoneNo, dateCreated: eventsManager.getTime(), reserved: 0)
                        eventsManager.addevent(event: event)
                        //update the values
                        numberOfSwipes = 1
                        location = "Marketplace"
                        date = Date()
                        message = "Thanks! your post is published"
                        phoneNo = ""
                    }
                }
            }
    }
}


struct NewSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewSwipeView().environmentObject(EventsManager())
    }
}
