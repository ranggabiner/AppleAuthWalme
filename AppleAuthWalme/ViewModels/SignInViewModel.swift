//
//  SignInViewModel.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//


import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var appUser: Users?
    @Published var errorMessage: String?

    let signInApple = SignInApple()
    
    func signInWithApple() async {
        do {
            let appleResult = try await signInApple.startSignInWithAppleFlow()
            let user = try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
            DispatchQueue.main.async {
                self.appUser = user
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error signing in with Apple: \(error.localizedDescription)"
            }
        }
    }
}
