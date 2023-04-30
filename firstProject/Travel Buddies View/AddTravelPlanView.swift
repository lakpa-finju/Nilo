//
//  AddTravelPlanView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-28.
//

import SwiftUI

struct AddTravelPlanView: View {
    @EnvironmentObject private var travelPlansManager: TravelPlansManager
    @EnvironmentObject private var userProfilesmanager: UserProfilesManager
    
    @State private var travelDate = Date()
    @State private var from = ""
    @State private var to = ""
    @State private var message = ""
    @State private var hasCar = false
    @State private var phoneNo = ""
    
    var body: some View {
            Form {
                Section(header: Text("Travel Information")) {
                    DatePicker("Travel Date", selection: $travelDate, displayedComponents: [.date,.hourAndMinute])
                    TextField("From", text: $from)
                    TextField("To", text: $to)
                }
                
                Section(header: Text("Contact Information")) {
                    Toggle("Do you have a car?", isOn: $hasCar)
                    TextField("Phone Number", text: $phoneNo)
                        .keyboardType(.phonePad)
                }
                
                Section(header: Text("Message to potential travel buddies")) {
                    TextEditor(text: $message)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Add Travel Plan")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let travelPlan = TravelPlan(id: UUID.init().uuidString, publisherId: userProfilesmanager.geteUserId(), publisherName: userProfilesmanager.getUserName(), phoneNo: phoneNo, from: from, to: to, hasCar: hasCar, travelDate: travelDate, message: message)
                        
                        travelPlansManager.addTravelPlan(travelPlan: travelPlan)
                    }
                    .disabled(from.isEmpty || to.isEmpty || phoneNo.isEmpty || message.isEmpty)
                }
            }
        
    }
}

struct AddTravelPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddTravelPlanView()
            .environmentObject(TravelPlansManager())
            .environmentObject(UserProfilesManager())
    }
}

