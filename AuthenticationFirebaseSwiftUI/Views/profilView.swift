//
//  profilView.swift
//  AuthenticationFirebaseSwiftUI
//
//  Created by Macbook on 27.07.2022.
//

import SwiftUI

struct profilView: View {
    let bio = """
 Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur
"""
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://picsum.photos/50/50"), scale: 2) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150.0, height: 150.0, alignment: .center)
                    .clipShape(Circle())
                
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.linear)
            }

            
            Text("Mohammed Ibno Abitaleb")
            Text(bio)
        }
    }
}

struct profilView_Previews: PreviewProvider {
    static var previews: some View {
        profilView()
    }
}
