//
//  UpdateNameViewModel.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import Foundation

class UpdateNameViewModel: ObservableObject {
    @Published var appUser: Users?
    @Published var name: String = ""
    @Published var showAlert: Bool = false

    private let userManager = UserManager.shared

    init(appUser: Users?) {
        self.appUser = appUser
    }

    func updateName() async {
        guard !name.isEmpty else {
            showAlert = true
            return
        }

        guard let userId = appUser?.id else {
            print("User ID not available")
            return
        }

        do {
            let isSuccess = try await userManager.updateUsername(userId: userId, newName: name)

            if isSuccess {
                appUser?.name = name
                showAlert = false
            } else {
                print("Failed to update user")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
