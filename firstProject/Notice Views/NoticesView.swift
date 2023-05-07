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
                                                    Text("Happening in \(minutes) minutes at \(dateFormatter2.string(from:value.eventDate))")
                                                        .foregroundColor(Color.white)
                                                }else{
                                                    Text("Happening in \(hours) hours at \(dateFormatter2.string(from:value.eventDate))")
                                                        .foregroundColor(Color.white)
                                                }
                                            } else if days == 1 {
                                                Text("Happening tomorrow in \(hours) hours at \(dateFormatter2.string(from:value.eventDate))")
                                                    .foregroundColor(Color.white)
                                            } else {
                                                Text("Happening on \(dateFormatter.string(from: value.eventDate))")
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
                                        //Image(systemName: "trash")
                                    }
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    
                                    //This expands the message and give the read more option if a user wants to read more about the event.
                                    Text(isExpanded ? value.noticeDescription : String(value.noticeDescription.prefix(50)))
                                        .foregroundColor(Color.white)
                                    if !isExpanded {
                                        Text("Read more")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                isExpanded = true
                                                                }
                                    }
                                    
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
                        .background(Color.primary)//cyan/ mint/indigo
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
