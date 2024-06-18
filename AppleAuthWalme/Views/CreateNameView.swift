//
//  CreateNameView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI

struct CreateNameView: View {
    @ObservedObject var viewModel: CreateNameViewModel
    @Binding var appUser: Users?

    var body: some View {
        VStack {
            TextField("Enter name", text: $viewModel.name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if viewModel.showAlert {
                Text("Name field cannot be empty")
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            Button(action: {
                Task {
                    await viewModel.createUser()
                    if let updatedUser = viewModel.appUser {
                        appUser = updatedUser
                    }
                }
            }) {
                Text("Create Name")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if let greeting = viewModel.greeting {
                Text(greeting)
                    .padding()
            }
            
            Button(action: {
                Task {
                    await viewModel.signOut()
                    appUser = nil
                }
            }) {
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    CreateNameView(viewModel: CreateNameViewModel(appUser: .init(id: "1234", email: "jajang@gmail.com", name: "Jajang")), appUser: .constant(.init(id: "1234", email: "jajang@gmail.com", name: "Jajang")))
}
