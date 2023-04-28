//
//  NoticesManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//

import Firebase
import FirebaseAuth

class NoticesManager: ObservableObject{
    @Published var notices: [String:Notice] = [:]

    
    init() {
        let db = Firestore.firestore()
        _ = db.collection("Notices").addSnapshotListener { snapshot, error in
            guard (snapshot?.documents) != nil else{
                print("Error fetching the document \(error?.localizedDescription ?? "from database")")
                return
            }
            self.fetchNotices()
        }
        
    }
    
    //function to fetch notices from the database
    func fetchNotices() {
        notices.removeAll()
        let db = Firestore.firestore()
        db.collection("Notices").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["Id"] as? String ?? ""
                    let publisherId = data["Publisher Id"] as? String ?? ""
                    let StudentOrganizationName = data["Organization name"] as? String ?? ""
                    let publisherEmail = data["Publisher email"] as? String ?? ""
                    let eventTimeStamp = data["Event Date"] as? Timestamp ?? Timestamp()
                    let eventDate = eventTimeStamp.dateValue()
                    let noticeDescription = data["Notice description"] as? String ?? ""
                    let eventLocation = data["Location"] as? String ?? ""
                    
                    let notice = Notice(id: id, publisherId: publisherId, studentOrganziationName:StudentOrganizationName , publisherEmail: publisherEmail, eventDate: eventDate, noticeDescription: noticeDescription, eventLocation: eventLocation)
                    self.notices[id] = notice
                }
            }
        }
    }
    
    //function to add notice to the database
    func addNotice(notice: Notice){
        let db = Firestore.firestore()
        let ref = db.collection("Notices").document(notice.id)
        ref.setData(["Id":notice.id,"Publisher Id":notice.publisherId, "Organization name":notice.studentOrganziationName,"Publisher email":notice.publisherEmail,"Event Date":notice.eventDate, "Notice description":notice.noticeDescription, "Location": notice.eventLocation as Any]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        notices[notice.id] = notice
        
    }
    
    //get the loggedin user Email
    private func getUserEmail() -> String{
        var email: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            email = user.email ?? "No Email"
        }
        return email
    }
    
    // get the loggedin event name
    private func getUserName() -> String{
        var name: String = "No Name"
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            name = user.displayName ??  "[Display Name]"
            
        }
        return name
    }
    
    // get the loggedin event id
    private func geteUserId() -> String{
        var userId: String = ""
        //getting the loggedin event
        let user = Auth.auth().currentUser
        if let user = user {
            userId = user.uid
        }
        return userId
    }
    
    //get time for record added.
    func getTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm:ss a zzz"
        let stringTime = dateFormatter.string(from: Date()) // Example output: "April 21, 2023 at 1:47:30 PM UTC-04:00"
        guard let time = dateFormatter.date(from: stringTime) else { return Date() }
        return time
        
    }
    
    //function to delete event from the database
    func deleteNotice(noticeId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Notices").document(noticeId)
        // Delete the document
        ref.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
        notices.removeValue(forKey: noticeId)
        
    }
    
    //function to update event to the database when someone clicks reserve
    func updateNotice(updatedNotice: Notice){
        let db = Firestore.firestore()
        let ref = db.collection("Notices").document(updatedNotice.id)
        ref.setData(["Id":updatedNotice.id,"Publisher Id":updatedNotice.publisherId, "Organization name":updatedNotice.studentOrganziationName,"Publisher email":updatedNotice.publisherEmail,"Event Date":updatedNotice.eventDate,"Notice description":updatedNotice.noticeDescription, "Location":updatedNotice.eventLocation as Any]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("Notice updated successfully")
            }
        }
        
    }
    

    
}
