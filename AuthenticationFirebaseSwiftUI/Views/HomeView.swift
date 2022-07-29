import SwiftUI
import Firebase

struct ChatUser {
    let uid, email, profileImageUrl: String
}


struct HomeView: View {
    @State var chatUser: ChatUser?
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var signOutProcessing = false
    @State private var text = "This is your amaizing Photo"
    

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
        AsyncImage(url: URL(string: "https://picsum.photos/50/50"), scale: 2) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300.0, height: 300.0, alignment: .center)
                .clipShape(Circle())
            
        } placeholder: {
            ProgressView()
                .progressViewStyle(.circular)
        }
            Text(text)
            .font(Font.system(size: 24).italic())

                .navigationTitle("Hello and welcome")
                .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                        if signOutProcessing {
                            ProgressView()
                        } else {
                            Button("Sign Out") {
                                signOutUser()
                            }
                        }
                    }
                }
        }
            Spacer()
        }
    }
    
    func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            signOutProcessing = false
        }
        withAnimation {
            viewRouter.currentPage = .signInPage
        }
    }
    
    func fetchUserInfo () {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.text = "Could not find firebase uid"
                      return
       }
        Firestore.firestore().collection("users").document(uid).getDocument { documentSnop, erreur in
            if let erreur = erreur {
                          self.text = "Failed to fetch current user: \(erreur)"
                          print("Failed to fetch current user:", erreur)
                          return
                      }
            guard let data = documentSnop?.data() else {
                            self.text = "No data found"
                            return

                        }
            let uid = data["uid"] as? String ?? ""
                     let email = data["email"] as? String ?? ""
                     let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            self.chatUser = ChatUser(uid: uid, email: email, profileImageUrl: profileImageUrl)
                    }
            
            
        }
        
     }
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
