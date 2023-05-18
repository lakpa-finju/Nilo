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
    @State private var itemStates: [String:Bool] = [:]
    //This is for readmore option
    @State private var isExpanded = false
    @State private var showingConfirmation = false
    
    private let dateFormatter2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return formatter
        }()
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a zzz"
            return formatter
        }()
    let calendar = Calendar.current
    
    var body: some View {
        
        VStack{
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(noticesManager.notices.sorted(by: {$0.value.eventDate < $1.value.eventDate}), id:\.key) { key, value in
                            if (Date() <= value.eventDate){
                                VStack{
                                    let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: value.eventDate)
                                    HStack{
                                        Spacer()
                                        if let days = timeDiff.day, let hours = timeDiff.hour, let minutes = timeDiff.minute {
                                            if days == 0 {
                                                if hours == 0 {
                                                    Text("In \(minutes) minutes at \(dateFormatter2.string(from:value.eventDate))")
                                                        .foregroundColor(Color("AdaptiveBackgroundColor"))
                                                }else{
                                                    Text("In \(hours) hours at \(dateFormatter2.string(from:value.eventDate))")
                                                        .foregroundColor(Color("AdaptiveBackgroundColor"))
                                                }
                                            } else if days == 1 {
                                                Text("Tomorrow in \(hours) hours at \(dateFormatter2.string(from:value.eventDate))")
                                                    .foregroundColor(Color("AdaptiveBackgroundColor"))
                                            } else {
                                                Text("\(dateFormatter.string(from: value.eventDate))")
                                                    .foregroundColor(Color("AdaptiveBackgroundColor"))
                                            }
                                        }
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
                                                message: Text("Are you sure you want to delete this notice?"),
                                                primaryButton: .destructive(Text("Delete")){
                                                    //perform the deletion action
                                                    noticesManager.deleteNotice(noticeId: value.id)
                                                },
                                                secondaryButton: .cancel())
                                        }
                                    }
                                    }
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    
                                    //This expands the message and give the read more option if a user wants to read more about the event.
                                    HStack{
                                        Spacer()
                                        Text(itemStates[value.id] == true ? value.noticeDescription : String(value.noticeDescription.prefix(50)))
                                            .foregroundColor(Color("AdaptiveBackgroundColor"))
                                        Spacer()
                                    }
                                    //read more option
                                    HStack{
                                        Spacer()
                                        Button(itemStates[value.id] == true ? "Read less" : "Read more") {
                                                itemStates[value.id]?.toggle()
                                            }
                                        .foregroundColor(Color.blue)
                                        Spacer()
                                    }
                                    //event location and organization
                                    HStack{
                                        Spacer()
                                        Text("\(value.eventLocation)")
                                            .foregroundColor(Color.white)
                                            .padding(.all, 10)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                        Spacer()
                                        Text("\(value.studentOrganziationName)")
                                            .foregroundColor(Color.white)
                                            .padding(.all, 10)
                                            .background(Color.purple)
                                            .cornerRadius(10)
                                        Spacer()
                                    }
                                }
                                
                            }
                     
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(40)
                        
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
                .onAppear{
                    itemStates = noticesManager.noticeIsExpanded
                }
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
