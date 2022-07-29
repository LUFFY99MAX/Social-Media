import SwiftUI

struct createPostView: View {
    @EnvironmentObject var postManager: PostManager
    @State private var title: String = ""
    @State private var tale: String = ""


    var body: some View {
        
        VStack {
            TextField("title", text: $title) // <1>, <2>
            TextField("tale", text: $tale) // <1>, <2>
            Button("Post") {
                postManager.createPost(newPost: title, tale: tale)
                
            }
                .buttonStyle(.bordered)
                .tint(.green)
      }
        .padding()
    }
}

struct addPostView_Previews: PreviewProvider {
    static var previews: some View {
        createPostView()
    }
}
