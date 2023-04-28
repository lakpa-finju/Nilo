//
//  NoticeView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//

import SwiftUI

struct AddNoticeView: View {
    @EnvironmentObject private var noticesManager: NoticesManager
    @EnvironmentObject private var userProfilesManager: UserProfilesManager
    @State private var id: String = ""
    @State private var publisherId: String = ""
    @State private var studentOrganziationName: String = ""
    @State private var publisherEmail: String = ""
    @State private var eventDate: Date = Date()
    @State private var noticeDescription = ""
    @State private var eventLocation = ""
    
    var body: some View {
            Form {
                Section(header: Text("Notice Information")) {
                    //TextField("ID", text: $id)
                    //TextField("Publisher ID", text: $publisherId)
                    TextField("Student Organization Name", text: $studentOrganziationName)
                    TextField("Event location", text: $eventLocation)
                    //TextField("Publisher Email", text: $publisherEmail)
                    DatePicker("Event Date", selection: $eventDate, displayedComponents: [.date, .hourAndMinute])
                    
                }
                Section(header: Text("Event invitation. Short, sweet, & welcoming"), content: {
                    TextEditor(text: $noticeDescription)
                        .font(.system(size: 24))
                        .lineLimit(nil)
                        .frame(minHeight: 200)
                })
                
                Button(action: {
                    let notice = Notice(id: UUID().uuidString, publisherId: userProfilesManager.geteUserId(), studentOrganziationName: studentOrganziationName, publisherEmail: userProfilesManager.getUserEmail(), eventDate: eventDate, noticeDescription: noticeDescription, eventLocation: eventLocation)
                    // Do something with the notice object, such as saving to a database
                    noticesManager.addNotice(notice: notice)
                    //empty it out!
                    studentOrganziationName = ""
                    eventLocation = ""
                    noticeDescription = "Thanks the description is submited it should be live anytime soon"
                    
                }) {
                    Text("Save Notice")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(50)
                        
                }
                .disabled(studentOrganziationName.isEmpty || eventLocation.isEmpty || noticeDescription.isEmpty)
            

                
                    
            }
            .navigationBarTitle("Create Notice")
        
        
        }
    
}

struct AddNoticesView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoticeView()
            .environmentObject(NoticesManager())
            .environmentObject(ProfileImagesManager())
    }
}
