import SwiftUI

struct ProfileImageUploadView: View {
    @EnvironmentObject private var profileImagesManager: ProfileImagesManager
    @EnvironmentObject private var userProfilesManager: UserProfilesManager
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Select an image")
            }
            Button(action: {
                self.showImagePicker = true
            }, label: {
                Text("Choose Image")
            })
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                ImagePickerView(selectedImage: $profileImage)
            })
        }
    }
    
    func loadImage() {
        guard let selectedImage = profileImage else { return }
        let profileImage = ProfileImage(id: userProfilesManager.getUserName() , image: selectedImage)
        profileImagesManager.uploadProfileImage(profileImage: profileImage)
        
        
    }
}


//Image Picker View
struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}



struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageUploadView()
            .environmentObject(ProfileImagesManager())
            .environmentObject(UserProfilesManager())
    }
}
