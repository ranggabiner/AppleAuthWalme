//
//  HomeView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import Foundation
import Supabase
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var appUser: Users?
    @State private var nameResult: String = ""

    let client = SupabaseClient(supabaseURL: URL(string: "https://oaezghaybcxjptqbtdzn.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hZXpnaGF5YmN4anB0cWJ0ZHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2MjY3OTQsImV4cCI6MjAzNDIwMjc5NH0.hfDso0hEbe7mVDfYo7OUjlpSeiuwvcqqb_HmncXTEpo")

    var body: some View {
        VStack {
            Text(viewModel.appUser?.id ?? "No User ID")
            Text(viewModel.appUser?.email ?? "No Email")
            Text(nameResult)

            Button(action: {
                Task {
                    await viewModel.signOut()
                    appUser = nil
                }
            }) {
                Text("Logout")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .onAppear {
            fetchUserNameById()
        }
        .onChange(of: appUser?.name) { newName in
            if let newName = newName {
                nameResult = newName
            }
        }
    }

    private func fetchUserNameById() {
        Task {
            do {
                let response = try await client.database.from("users").select().eq("id", value: viewModel.appUser?.id).execute()
                
                guard response.status == 200 else {
                    nameResult = "Not Found"
                    return
                }
                
                guard let data = response.data as? Data else {
                    nameResult = "Not Found"
                    return
                }
                
                guard !data.isEmpty else {
                    nameResult = "Not Found"
                    return
                }
                
                if let user = try? JSONDecoder().decode([Users].self, from: data), let firstName = user.first {
                    nameResult = firstName.name ?? "No Name"
                } else {
                    nameResult = "Not Found"
                }
            } catch {
                print("Error searching group: \(error.localizedDescription)")
                nameResult = "Error"
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(appUser: .init(id: "1234", email: "jajang@gmail.com", name: "Jajang")), appUser: .constant(.init(id: "1234", email: "jajang@gmail.com", name: "Jajang")))
}
