//
//  UpdateNameView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI
import Supabase

struct UpdateNameView: View {
    @ObservedObject var viewModel: UpdateNameViewModel
    @Binding var appUser: Users?

    @State private var name: String = ""
    @State private var greeting: String? = nil

    let client = SupabaseClient(supabaseURL: URL(string: "https://oaezghaybcxjptqbtdzn.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hZXpnaGF5YmN4anB0cWJ0ZHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2MjY3OTQsImV4cCI6MjAzNDIwMjc5NH0.hfDso0hEbe7mVDfYo7OUjlpSeiuwvcqqb_HmncXTEpo")

    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: createUser) {
                Text("Update Name")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if let greeting = greeting {
                Text(greeting)
                    .padding()
            }
        }
        .padding()
    }

    func createUser() {
        guard let userId = viewModel.appUser?.id else {
            print("User ID not available")
            return
        }
        
        guard let userEmail = viewModel.appUser?.email else {
            print("User Email not available")
            return
        }
        
        let newUser = Users(id: userId, email: userEmail, name: name)
        
        Task {
            do {
                let updateResponse = try await client.database.from("users").update(["name": name]).eq("id", value: userId).execute()
                
                if updateResponse.status == 200 {
                    appUser?.name = name
                    greeting = "Hello \(name)"
                } else {
                    print("Failed to update user")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    CreateNameView(viewModel: CreateNameViewModel(appUser: .init(id: "1234", email: "jajang@gmail.com", name: "Jajang")), appUser: .constant(.init(id: "1234", email: "jajang@gmail.com", name: "Jajang")))
}
