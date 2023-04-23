//
//  UserFileHandler.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//
import SwiftUI
import FirebaseStorage

class ProfileImagesManager: ObservableObject{
    
    
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
    
    
    //Function to get profile image from the database
    func getProfileImage(profileImageId:String) {
        let storage = Storage.storage()
        let profileImageRef = storage.reference(withPath: "Profile images/\(profileImageId).jpg")
        
        
    }
    
}
