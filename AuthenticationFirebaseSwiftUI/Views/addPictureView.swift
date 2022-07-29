import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct addPictureView: View {
    @State private var image: Image? =  Image(systemName: "person")
    @State private var shouldPresentImagePicker = false
    @State var image3 = ""
    
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State var shouldShowImagePicker = false
    @State var image2: UIImage?
    @State var StatusMessage = ""
            
    var body: some View {
        // WARNING: Force wrapped image for demo purpose
        NavigationView {
            ZStack {
                Color.black
                VStack(spacing: 20) {
                image!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.green)
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .opacity(0.1)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                          image: self.$image,
                                          isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"),
                                message: Text("Please choose your preferred mode to set your profile image"),
                                buttons: [ActionSheet.Button.default(Text("Camera"),
                                action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
                    
                    NavigationLink(
                       destination:HomeView()
                       .navigationBarBackButtonHidden(true)
                       .navigationBarHidden(true)) {
                           if self.image != Image(systemName: "person") {
                               Text("Next")
                                           .foregroundColor(.green)
                                           .onTapGesture {
//                               persistImageToStorage()
                               persistImageToStorage2()


                                           }
                           }
                       }
                    Button {
                           shouldShowImagePicker.toggle()
                       } label: {
                    if let image = self.image2 {
                        Image(uiImage: image2!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(.red)
                                }
                       }
                    
                    Button("Add photo profil") {
                        print("Ooooh yeah continue!")
//                        persistImageToStorage()
                        persistImageToStorage2()
                                                }
                                .buttonStyle(.bordered)
                                .tint(.green)
                                            }
                .navigationViewStyle(StackNavigationViewStyle())
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                    ImagePicker(image: $image2)
                    .ignoresSafeArea()
                            }
            }
        }
   }
    func persistImageToStorage2() {
        
        guard image2 != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
         let imageData = image2?.jpegData(compressionQuality: 0.5)
        
        guard imageData != nil else {
            return
        }
        
        let path = ("images/\(UUID().uuidString).jpg")


        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")

        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
         
        if error == nil && metadata != nil {
            print(error)

        }
        }
        
        Firestore.firestore().collection("messages").document().setData(["url" : path])
        
       }
    }
struct addPicture2_Previews: PreviewProvider {
    static var previews: some View {
        addPictureView()
    }
}
