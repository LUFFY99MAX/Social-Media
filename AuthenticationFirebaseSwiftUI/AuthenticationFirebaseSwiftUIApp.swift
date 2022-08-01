import SwiftUI
import Firebase

@main
struct AuthenticationFirebaseSwiftUIApp: App {
    @StateObject var viewRouter = ViewRouter()
    init() { FirebaseApp.configure() }

    var body: some Scene {
        WindowGroup {
//            MotherView()
//            .environmentObject(viewRouter)
            postView()
                .environmentObject(PostManager())
//            
//                SignInView()
//            tryAddDataToFirestore(viewRouter: ViewRouter())
        }
    }
}
