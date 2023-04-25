//
//  UserFileHandler.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-22.
//
import Combine
import FirebaseStorage
import SDWebImage

class ProfileImagesManager: ObservableObject {

    // Function to Upload UserFile in the database
    func uploadProfileImage(profileImage: ProfileImage) {
        let uploadRef = Storage.storage().reference(withPath: "Profile images/\(profileImage.id).jpg")
        guard let imageData = profileImage.image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image in uploadProFileImage method")
            return
        }
        let uploadMetaData = StorageMetadata.init() //to get additional info in the firebase storage for easy classification
        uploadMetaData.contentType = "image/jpeg"
        uploadRef.putData(imageData, metadata: uploadMetaData) { (downloadedMetaData, error) in
            if let error = error {
                print("there was an error while uploading profile Image \(error.localizedDescription)")
            }
            print("Profile Image is uploaded successfully!")
        }
    }
    
    
    //Load profile picture for logged in user
    func loadProfileImage(profileImageId: String) -> UIImage? {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let profileImageRef = storageRef.child("Profile images/\(profileImageId).jpg")
        
        // Check if image is already cached
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: profileImageRef.fullPath) {
            return cachedImage
        }
        
        // Download and cache image
        var downloadedImage: UIImage?
        
        profileImageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error getting profile image URL: \(error.localizedDescription)")
            } else if let url = url {
                SDWebImageDownloader.shared.downloadImage(with: url, options: [.continueInBackground, .scaleDownLargeImages], progress: nil) { (image, data, error, finished) in
                    if let error = error {
                        print("Error downloading profile image: \(error.localizedDescription)")
                    } else if let image = image {
                        SDImageCache.shared.store(image, forKey: profileImageRef.fullPath)
                        downloadedImage = image
                        print("Image downloading to local cache!")
                    }
                    
                }
            }
        }
        return downloadedImage
    }
    
}
