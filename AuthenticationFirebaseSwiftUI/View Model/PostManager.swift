
import Firebase
import Foundation

class PostManager: ObservableObject {
    @Published var posts: [Post] = []
    init() {
        fetchPost()
    }
    
    func fetchPost() {
        posts.removeAll()
        let ref = Firestore.firestore().collection("Post")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    
                    let data  = document.data()
                    let title = data["title"] as? String ?? ""
                    let tale = data["tale"]   as? String ?? ""
                    let id = data["id"]       as? String ?? ""
                    
                    let post = Post(id: UUID(), title: title, tale: tale)
                    self.posts.append(post)
 
                }
            }
            
        }
        
    }
    func createPost(newPost: String, tale: String) {
        let ref = Firestore.firestore().collection("Post").document(newPost)
        ref.setData(["title" : newPost, "tale" : tale]) { error in
            if let error = error {
                print(error)
                
            }
            
        }
    }
    

}
