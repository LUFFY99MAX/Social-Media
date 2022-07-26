//
//  ViewRouter.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class ViewRouter: ObservableObject {
      // MARK: - Properety wrapper
      @Published var currentPage: Page = .signInPage
      @Published var signInProcessing = false
    
      // MARK: - Propereties add user info to Backend
      @Published var data: Data = Data(email: "")
      private var db = Firestore.firestore()
    
      // MARK: - Propereties Auth Sign up
      @Published var signUpProcessing = false
      @Published var signUpErrorMessage = ""
      
    func signUpUser(userEmail: String, userPassword: String, email:String) {
        
        // MARK: - Part of fuction about Authentification
        signUpProcessing = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                self.signUpErrorMessage = error!.localizedDescription
                self.signUpProcessing = false
                return
            }
            switch authResult {
            case .none:
                print("Could not create account.")
                self.signUpProcessing = false
            case .some(_):
                print("User created")
                self.signUpProcessing = false
                self.currentPage = .homePage
            }
            // MARK: - Part of fuction about Firestore
            let docRef = self.db.collection("Message").addDocument(data: ["email": email])
        
        docRef.setData(["email": email]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            // MARK: - Part of fuction about Upload image to Firestore

        
    }

            
           
        }
        
    }
}
            enum Page {
                case signUpPage
                case signInPage
                case homePage
            }

struct Data {
    var email: String

    
}

