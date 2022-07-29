//
//  SignInView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    
//    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    var body: some View {
        
        ZStack {
         VStack(spacing: 15) {
             Text("Beliver Media")
                 .bold()
                 .font(.largeTitle)
                 .foregroundColor(Color("color4"))
            
            Image("guitar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 200.0, alignment: .center)
            
            Spacer()
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(!viewRouter.signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
            if viewRouter.signInProcessing {
                ProgressView()
            }
            if !signInErrorMessage.isEmpty {
                Text("Failed creating account: \(signInErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.white)
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color("color4"))
                }
            }
                .opacity(0.9)
            }
    }
            .padding()
            .background(Color.black)
    }
    
    func signInUser(userEmail: String, userPassword: String) {
        viewRouter.signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                viewRouter.signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                viewRouter.signInProcessing = false
            case .some(_):
                print("User signed in")
                viewRouter.signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
            
        }

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.bottom, 30)
        }
    }
}
