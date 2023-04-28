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
            Text("Travel Plans")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(travelPlansManager.travelPlans.sorted(by: {$0.value.travelDate > $1.value.travelDate}), id:\.key) { key, value in
                            if (Date() <= value.travelDate){
                                VStack{
                                    Text("Travel Date: \(dateFormatter.string(from: value.travelDate))")
                                    HStack{
                                        Text("From: \(value.from)")
                                        Text("To: \(value.to)")
                                    }
                                    Text("Name: \(value.publisherName)")
                                    Text("Phone No: \(value.phoneNo)")
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                                .font(.system(.body))
                            }
                            if(userProfilesManager.geteUserId() == value.publisherId){
                                Button {
                                    if(travelPlansManager.travelPlans[value.id] != nil){
                                        travelPlansManager.travelPlans.removeValue(forKey: value.id)
                                    }
                                } label: {
                                    Text("Remove plan")
                                }

                            }
                            
                        }
                        
                    }
                    .padding()
                    
                    
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
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
