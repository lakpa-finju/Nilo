//
//  NoticesView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//

import SwiftUI
struct NoticesView: View {
    @EnvironmentObject private var noticesManager: TravelPlansManager
    @EnvironmentObject private var userProfilesManager: UserProfilesManager
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a zzz"
            return formatter
        }()
    
    var body: some View {
        
        VStack{
            Text("Campus Events")
                .font(.system(.title))
            
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(noticesManager.notices.sorted(by: {$0.value.eventDate > $1.value.eventDate}), id:\.key) { key, value in
                            if (Date() <= value.eventDate){
                                VStack{
                                Text("Invitation: \(value.noticeDescription)")
                                Text("Location: \(value.eventLocation)")
                                Text("Date: \(dateFormatter.string(from: value.eventDate))")
                                Text("Organization:\(value.studentOrganziationName)")
                                
                            }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(10)
                        }
                        }
                        
                    }
                    .padding()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                        
                            NavigationLink{
                                AddNoticeView()
                                    .environmentObject(noticesManager)
                                    .environmentObject(userProfilesManager)
                            }label: {
                                Text("Create notice")
                            }

                            
                        })
                    }
                    
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        
        Spacer()
    }
    
    
    struct NoticesView_Previews: PreviewProvider {
        static var previews: some View {
            NoticesView()
                .environmentObject(TravelPlansManager())
                .environmentObject(UserProfilesManager())
        }
    }
}
