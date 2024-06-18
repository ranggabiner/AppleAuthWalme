//
//  UpdateNameView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI

struct UpdateNameView: View {
    @ObservedObject var viewModel: UpdateNameViewModel
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
                    await viewModel.updateName()
                    if let updatedUser = viewModel.appUser {
                        appUser = updatedUser
                    }
                }
            }) {
                Text("Update Name")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    UpdateNameView(viewModel: UpdateNameViewModel(appUser: .init(id: "1234", email: "jajang@gmail.com", name: "Jajang")), appUser: .constant(.init(id: "1234", email: "jajang@gmail.com", name: "Jajang")))
}
