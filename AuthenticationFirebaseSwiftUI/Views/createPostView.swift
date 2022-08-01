import SwiftUI

struct createPostView: View {
    @EnvironmentObject var postManager: PostManager
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    
    @State private var tale: String = ""
    @State private var inputText = "We so excited to her something about u?"
    init() { UITextView.appearance().backgroundColor = .clear }

    var body: some View {
        
        ZStack {
            Color.black
                .opacity(0.9)
            VStack(alignment: .leading) {
                Text("Tell the world about you story receive advices we all familly")
                .font(.custom("PlayfairDisplay-Bold", size: 40))
                .foregroundColor(Color("color3"))


                VStack(alignment: .leading) {
                    Text("Set a title of your story")
                        .font(.custom("PlayfairDisplay-Bold", size: 24))
                        .foregroundColor(.white)
                        .opacity(0.8)
                    TextField("title", text: $title)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .opacity(0.7)
                        .cornerRadius(15)



                }
                
                VStack(alignment: .leading) {
                    Text("Set a title of your story")
                        .font(.custom("PlayfairDisplay-Bold", size: 24))
                        .foregroundColor(.white)
                        .opacity(0.8)
//                    TextField("tale", text: $tale)
                    TextEditor(text: $inputText)
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .opacity(0.7)
                        .cornerRadius(15)
                        .frame(height: 200)
                }
    
                Button {
                    postManager.createPost(newPost: title, tale: inputText)
                    dismiss()
               } label: {
                   Text("Post")
                       .padding()
                       .foregroundColor(.black)
                       .background(.purple)
                       .cornerRadius(4)
               }
            }
            .padding()
        }
        .ignoresSafeArea()

    }
}
    

struct addPostView_Previews: PreviewProvider {
    static var previews: some View {
        createPostView()
    }
}
