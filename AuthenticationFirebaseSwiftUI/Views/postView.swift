import SwiftUI

struct postView: View {
    @EnvironmentObject var vm: PostManager
    @State private var showPopUp = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {            
            
        ScrollView {
            Text("Tales")
                .bold()
                .font(.largeTitle)
                .padding(.vertical)
            
        ForEach(vm.posts, id: \.id) { post in
            
        VStack(alignment: .leading) {
            Text(post.title)
                .bold()
                .font(.system(size: 21))
            Text(post.tale)
                .padding()
                .background(.gray)
                .cornerRadius(15)
            
        }
        .padding()
          }
        }
            Image(systemName: "pencil.circle.fill")
                .font(.system(size: 30))
                .padding(10)
                .onTapGesture {
                    showPopUp.toggle()
                    
                }
                .sheet(isPresented: $showPopUp) {
                    createPostView()
                    
                }

 }
    }
}

struct postView_Previews: PreviewProvider {
    static var previews: some View {
           postView()
            .environmentObject(PostManager())
    }
}
