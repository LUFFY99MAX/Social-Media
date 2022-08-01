import SwiftUI

struct postView: View {
    @EnvironmentObject var vm: PostManager
    @State private var showPopUp = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {            
            
        ScrollView {
            VStack(alignment: .leading) {
            Text("Stories")
                    .foregroundColor(Color("color3"))
                .bold()
                .font(.custom("PlayfairDisplay-Bold", size: 40))
//                .font(.custom("La"))
                .padding(15)
            
        ForEach(vm.posts, id: \.id) { post in
            
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.custom("PlayfairDisplay-Bold", size: 24))
//                .font(.system(size: 24))
                .foregroundColor(.white)
                .bold()
                .padding()
            
            Text(post.tale)
                .font(.custom("Lato-Regular", size: 18))

                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding()
                .frame(width: 400, alignment: .leading)
                .cornerRadius(15)
            
        }
        .background(Color("color2"))
        .cornerRadius(15)
        .padding()

          }
        }
    }
        .background(.black)
        .opacity(0.95)
            Image(systemName: "pencil.circle.fill")
                .foregroundColor(Color("color3"))
                .font(.system(size: 60))
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
