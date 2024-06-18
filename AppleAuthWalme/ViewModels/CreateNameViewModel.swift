//
//  CreateNameViewModel.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import Foundation

class CreateNameViewModel: ObservableObject {
    @Published var appUser: Users?
    @Published var name: String = ""
    @Published var greeting: String? = nil
    @Published var showAlert: Bool = false


    private let userManager = UserManager.shared

    init(appUser: Users?) {
        self.appUser = appUser
    }

    func createUser() async {
        guard !name.isEmpty else {
            showAlert = true
            return
        }
        
        guard let userId = appUser?.id else {
            print("User ID not available")
            return
        }
        
        guard let userEmail = appUser?.email else {
            print("User Email not available")
            return
        }
        
        let newUser = Users(id: userId, email: userEmail, name: name)
        
        do {
            let isSuccess = try await userManager.insertUsername(newUser)
                
            if isSuccess {
                appUser?.name = name
                greeting = "Hello \(name)"
                showAlert = false
            } else {
                print("Failed to create user")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await userManager.signOut()
            appUser = nil
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
