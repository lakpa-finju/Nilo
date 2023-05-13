//
//  TravelPlansView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-28.
//

import SwiftUI

struct TravelPlansView: View {
    @EnvironmentObject private var travelPlansManager: TravelPlansManager
    @EnvironmentObject private var userProfilesManager: UserProfilesManager
    
    @State private var isExpanded = false
    @State private var itemStates: [String:Bool] = [:]
    @State private var showingConfirmation = false
    // for filtering the search results.
    @State var selectedDate: Date = Date()
    @State private var filterByDate = false
    let calendar = Calendar.current
    
    private let dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d 'at' h:mm a zzz"
        return formatter
    }()
    
    var body: some View {
        
        VStack{
            VStack {
                Toggle("Filter by date", isOn: $filterByDate)
                if filterByDate {
                    DatePicker("select Date", selection: $selectedDate, displayedComponents: [.date])
                }
            }
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        if calendar.isDate(Date(), equalTo: selectedDate, toGranularity: .day){
                            ForEach(travelPlansManager.travelPlans
                                .sorted(by: {$0.value.travelDate < $1.value.travelDate}), id:\.key) { key, value in
                                    if (Date() <= value.travelDate) {
                                        VStack(alignment: .leading){
                                            HStack{
                                                Spacer()
                                                Text("\(value.from) to \(value.to)")
                                                    .bold()
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding(5)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                                Spacer()
                                                //This gives the option of deleting the notice if created by the user itself.
                                                if(userProfilesManager.geteUserId() == value.publisherId){
                                                    Button(action: {
                                                        showingConfirmation = true
                                                    }) {
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.white)
                                                            .padding(5)
                                                            .background(Color.red)
                                                            .clipShape(Circle())
                                                    }
                                                    .alert(isPresented: $showingConfirmation) {
                                                        Alert(
                                                            title: Text("Delete Notice"),
                                                            message: Text("Are you sure you want to delete the travel plan notice?"),
                                                            primaryButton: .destructive(Text("Delete")){
                                                                //perform the deletion action
                                                                travelPlansManager.deleteTravelPlan(travelPlanId: value.id)
                                                            },
                                                            secondaryButton: .cancel())
                                                    }
                                                }
                                            }
                                            //This is for date formatting
                                            HStack{
                                                let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: value.travelDate)
                                                if let days = timeDiff.day, let hours = timeDiff.hour, let minutes = timeDiff.minute {
                                                    Spacer()
                                                    if days == 0 {
                                                        if hours == 0 {
                                                            Text("Travelling in \(minutes) minutes at \(dateFormatter2.string(from:value.travelDate))")
                                                                .foregroundColor(Color.white)
                                                        } else {
                                                            Text("Travelling in \(hours) hours and \(minutes) minutes at \(dateFormatter2.string(from:value.travelDate))")
                                                                .foregroundColor(Color.white)
                                                        }
                                                    } else if days == 1 {
                                                        Text("Travelling tomorrow in \(hours) hours at \(dateFormatter2.string(from:value.travelDate))")
                                                            .foregroundColor(Color.white)
                                                    } else {
                                                        Text("Travelling on \(dateFormatter.string(from: value.travelDate))")
                                                            .foregroundColor(Color.white)
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            //for phone number and name
                                            HStack{
                                                Spacer()
                                                Text("\(value.publisherName)")
                                                    .foregroundColor(Color.white)
                                                    .background(Color.blue)
                                                    .cornerRadius(5)
                                                Spacer()
                                                Text("\(value.phoneNo)")
                                                    .foregroundColor(Color.white)
                                                    .background(Color.purple)
                                                    .cornerRadius(5)
                                                Spacer()
                                            }
                                            //For text expansion
                                            HStack{
                                                Spacer()
                                                Text(itemStates[value.id] == true ? value.message : String(value.message.prefix(50)))
                                                    .foregroundColor(Color.white)
                                                Spacer()
                                            }
                                            // read more button
                                            HStack{
                                                Spacer()
                                                Button(itemStates[value.id] == true ? "Read less" : "Read more") {
                                                                        itemStates[value.id]?.toggle() // Toggle state variable when button is tapped
                                                                    }
                                                .foregroundColor(Color.blue)
                                                Spacer()
                                            }
                                        }
                                    }
                                   
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(40)
                            
                            
                        } else{
                            ForEach(travelPlansManager.travelPlans
                                .sorted(by: {$0.value.travelDate < $1.value.travelDate}), id:\.key) { key, value in
                                    if calendar.isDate(selectedDate, equalTo: value.travelDate, toGranularity: .day) {
                                        VStack(alignment: .leading){
                                            HStack{
                                                Spacer()
                                                Text("\(value.from) to \(value.to)")
                                                    .bold()
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding(5)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                                Spacer()
                                                if(userProfilesManager.geteUserId() == value.publisherId){
                                                    Button(action: {
                                                        showingConfirmation = true
                                                    }) {
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.white)
                                                            .padding(5)
                                                            .background(Color.red)
                                                            .clipShape(Circle())
                                                    }
                                                    .alert(isPresented: $showingConfirmation) {
                                                        Alert(
                                                            title: Text("Delete Notice"),
                                                            message: Text("Are you sure you want to delete the travel plan notice?"),
                                                            primaryButton: .destructive(Text("Delete")){
                                                                //perform the deletion action
                                                                travelPlansManager.deleteTravelPlan(travelPlanId: value.id)
                                                            },
                                                            secondaryButton: .cancel())
                                                    }
                                                }
                                            }
                                            HStack{
                                                let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: value.travelDate)
                                                if let days = timeDiff.day, let hours = timeDiff.hour, let minutes = timeDiff.minute {
                                                    Spacer()
                                                    if days == 0 {
                                                        if hours == 0 {
                                                            Text("Travelling in \(minutes) minutes at \(dateFormatter2.string(from:value.travelDate))")
                                                                .foregroundColor(Color.white)
                                                        } else {
                                                            Text("Travelling in \(hours) hours and \(minutes) minutes at \(dateFormatter2.string(from:value.travelDate))")
                                                                .foregroundColor(Color.white)
                                                        }
                                                    } else if days == 1 {
                                                        Text("Travelling tomorrow in \(hours) hours at \(dateFormatter2.string(from:value.travelDate))")
                                                            .foregroundColor(Color.white)
                                                    } else {
                                                        Text("Travelling on \(dateFormatter.string(from: value.travelDate))")
                                                            .foregroundColor(Color.white)
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            //for phone number and name
                                            HStack{
                                                Spacer()
                                                Text("\(value.publisherName)")
                                                    .foregroundColor(Color.white)
                                                    .background(Color.blue)
                                                    .cornerRadius(5)
                                                Spacer()
                                                Text("\(value.phoneNo)")
                                                    .foregroundColor(Color.white)
                                                    .background(Color.purple)
                                                    .cornerRadius(5)
                                                Spacer()
                                            }
                                            //For text expansion
                                            HStack{
                                                Spacer()
                                                Text(itemStates[value.id] == true ? value.message : String(value.message.prefix(50)))
                                                    .foregroundColor(Color.white)
                                                Spacer()
                                            }
                                            // read more button
                                            HStack{
                                                Spacer()
                                                Button(itemStates[value.id] == true ? "Read less" : "Read more") {
                                                                        itemStates[value.id]?.toggle() // Toggle state variable when button is tapped
                                                                    }
                                                .foregroundColor(Color.blue)
                                                Spacer()
                                            }
                                            
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(40)
                            
                            
                        }
                    }
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear{
                    itemStates = travelPlansManager.travelMessageExapand
                }
            }
        }
        .navigationTitle("Travel Plans")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink{
                    AddTravelPlanView()
                        .environmentObject(travelPlansManager)
                        .environmentObject(userProfilesManager)
                }label: {
                    HStack{
                        Text("Add Travel Plan")
                        Image(systemName: "car.circle.fill")
                    }
                }
                
            })
        }
        //.navigationBarItems(trailing: filterToggle) // This is the toggle
        
        Spacer()
    }
        
    
    var filterToggle: some View {
        Toggle(isOn: $filterByDate) {
            Image(systemName: "line.horizontal.3.decrease.circle")
        }
        .toggleStyle(.button)
        //.disabled(!filterByDate && selectedDate == nil)
        //.animation(.default)
        .sheet(isPresented: $filterByDate) {
            VStack {
                DatePicker(
                    "Filter by Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                Button("Apply", action: {
                    filterByDate = false
                })
                .padding()
            }
        }
    }
}

struct TravelPlansView_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlansView()
            .environmentObject(TravelPlansManager())
            .environmentObject(UserProfilesManager())
    }
}
