//
//  HomeViewModel.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var appUser: Users?

    init(appUser: Users?) {
        self.appUser = appUser
    }

    func signOut() async {
        do {
            try await AuthManager.shared.signOut()
            DispatchQueue.main.async {
                self.appUser = nil
            }
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
