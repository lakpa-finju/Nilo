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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a zzz"
        return formatter
    }()
    
    var body: some View {
        
        VStack{
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(travelPlansManager.travelPlans.sorted(by: {$0.value.travelDate < $1.value.travelDate}), id:\.key) { key, value in
                            if (Date() <= value.travelDate){
                                VStack(alignment: .leading){
                                    Text("\(value.from) to \(value.to)")
                                        .bold()
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .offset(x:geometry.size.width/6)
                                    Text("Travel Date: \(dateFormatter.string(from: value.travelDate))")
                                    Text("Name: \(value.publisherName)")
                                    Text("Phone No: \(value.phoneNo)")
                                    Text("Message: \(value.message)")
                                        .bold()
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)
                                .cornerRadius(20)
                                .font(.system(size: 14))
                                
                            }
                            if(userProfilesManager.geteUserId() == value.publisherId){
                                    Button {
                                        travelPlansManager.deleteTravelPlan(travelPlanId: value.id)
                                    } label: {
                                        Text("Remove Travel Plan")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                            .padding(5)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                    }

                                    
                                                                
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                    
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationTitle("Travel Plans")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink{
                    EmptyView()
                }label: {
                    HStack{
                        Text("Add Travel Plan")
                        Image(systemName: "car.circle.fill")
                    }
                    }

                })
        }
        
        Spacer()
    }
}

struct TravelPlansView_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlansView()
            .environmentObject(TravelPlansManager())
            .environmentObject(UserProfilesManager())
    }
}
