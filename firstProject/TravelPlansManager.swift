//
//  TravelPlansManager.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//


import Firebase
import FirebaseAuth

class TravelPlansManager: ObservableObject{
    @Published var travelPlans: [String:TravelPlan] = [:]
    //Initially the message of the items will only be show to 50 char and given option of read more. Based on the below status.
    @Published var travelMessageExapand: [String: Bool] = [:]
    
    init() {
        let db = Firestore.firestore()
        _ = db.collection("Travel buddies").addSnapshotListener { snapshot, error in
            guard (snapshot?.documents) != nil else{
                print("Error fetching the document \(error?.localizedDescription ?? "from database")")
                return
            }
            self.fetchTravelPlans()
        }
        
    }
    
    //function to fetch notices from the database
    func fetchTravelPlans() {
        travelPlans.removeAll()
        let db = Firestore.firestore()
        db.collection("Travel buddies").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["Id"] as? String ?? ""
                    let publisherId = data["Publisher Id"] as? String ?? ""
                    let publisherName = data["Publisher Name"] as? String ?? ""
                    let travelTimeStamp = data["Travel Date"] as? Timestamp ?? Timestamp()
                    let travelDate = travelTimeStamp.dateValue()
                    let message = data["Message"] as? String ?? ""
                    let from = data["From"] as? String ?? ""
                    let to = data["To"] as? String ?? ""
                    let hasCar = data["Has Car"] as? Bool ?? false
                    let phoneNo = data["Phone number"] as? String ?? ""
                    
                    let travelPlan = TravelPlan(id: id, publisherId: publisherId, publisherName: publisherName, phoneNo: phoneNo, from: from, to: to, hasCar: hasCar, travelDate: travelDate, message: message)
                    self.travelPlans[id] = travelPlan
                    self.travelMessageExapand[id] = false
                }
            }
        }
    }
    
    //function to add travel plan to the database
    func addTravelPlan(travelPlan: TravelPlan){
        let db = Firestore.firestore()
        let ref = db.collection("Travel buddies").document(travelPlan.id)
        ref.setData(["Id":travelPlan.id,"Publisher Id":travelPlan.publisherId,"Publisher Name":travelPlan.publisherName, "Travel Date":travelPlan.travelDate, "Message":travelPlan.message, "From":travelPlan.from, "To":travelPlan.to, "Has Car":travelPlan.hasCar, "Phone number":travelPlan.phoneNo]){
            error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        travelPlans[travelPlan.id] = travelPlan
        
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
    func deleteTravelPlan(travelPlanId: String){
        let db = Firestore.firestore()
        let ref = db.collection("Travel buddies").document(travelPlanId)
        // Delete the document
        ref.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
        travelPlans.removeValue(forKey: travelPlanId)
        
    }
    

    
}

