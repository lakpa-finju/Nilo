//
//  UserFileHandler.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//
import SwiftUI
import FirebaseStorage

class ProfileImagesManager: ObservableObject{
    @Published var profileImage: UIImage?
    
    init() {
        let userProfilesManager = UserProfilesManager()
        loadProfileImage(profileImageId: userProfilesManager.getUserName())
    }
    
    //Function to Upload UserFile in the database
    func uploadProfileImage(profileImage: ProfileImage){
        let uploadRef = Storage.storage().reference(withPath: "Profile images/\(profileImage.id).jpg")
        guard let imageData = profileImage.image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image in uploadProFileImage method")
            return }
        let uploadMetaData = StorageMetadata.init() //to get additional info in the firebase storage for easy classification
        uploadMetaData.contentType = "image/jpeg"
        uploadRef.putData(imageData, metadata: uploadMetaData){(downloadedMetaData, error) in
            if let error = error {
                print("there was an error while uploading profile Image \(error.localizedDescription)")
            }
            print("Profile Image is uploaded successfully!")
        }
    }
    
    
    //Function to load profile when ProfileImageId is passedIn
    func loadProfileImage(profileImageId: String) {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let profileImageRef = storageRef.child("Profile images/\(profileImageId).jpg")
            
            profileImageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error getting profile image URL: \(error.localizedDescription)")
                } else if let url = url {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print("Error loading profile image: \(error.localizedDescription)")
                        } else if let data = data {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.profileImage = image
                                }
                            }
                        }
                    }.resume()
                }
            }
        }
}
