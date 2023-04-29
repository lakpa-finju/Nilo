//
//  NoticesView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//

import SwiftUI
struct NoticesView: View {
    @EnvironmentObject private var noticesManager: NoticesManager
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
                        ForEach(noticesManager.notices.sorted(by: {$0.value.eventDate < $1.value.eventDate}), id:\.key) { key, value in
                            if (Date() <= value.eventDate){
                                VStack{
                                    VStack{
                                        Text("Invitation:")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                        Text("\(value.noticeDescription)")
                                        Spacer()
                                    }
                                    HStack{
                                        Text("Location:")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                        Text("\(value.eventLocation)")
                                        Spacer()
                                    }
                                    HStack{
                                        Text("Date:")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                        Text("\(dateFormatter.string(from: value.eventDate))")
                                        Spacer()
                                    }
                                    HStack{
                                        Text("Organization:")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                        Text("\(value.studentOrganziationName)")
                                        Spacer()
                                    }
                                    if(userProfilesManager.geteUserId() == value.publisherId){
                                        Button {
                                            noticesManager.deleteNotice(noticeId: value.id)
                                        } label: {
                                            Text("Remove Notice")
                                                .font(.headline)
                                                .foregroundColor(.red)
                                                .padding(5)
                                                .background(Color.black)
                                                .cornerRadius(10)
                                        }

                                    }
                                
                            }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)//cyan/ mint/indigo
                                .cornerRadius(40)
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
        .navigationTitle("Campus Events")
        
        Spacer()
    }
    
    
    
    struct NoticesView_Previews: PreviewProvider {
        static var previews: some View {
            NoticesView()
                .environmentObject(NoticesManager())
                .environmentObject(UserProfilesManager())
        }
    }
}
