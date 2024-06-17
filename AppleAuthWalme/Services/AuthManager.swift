//
//  AuthManager.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import Foundation
import Supabase

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://oaezghaybcxjptqbtdzn.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hZXpnaGF5YmN4anB0cWJ0ZHpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2MjY3OTQsImV4cCI6MjAzNDIwMjc5NH0.hfDso0hEbe7mVDfYo7OUjlpSeiuwvcqqb_HmncXTEpo")

    func getCurrentSession() async throws -> Users {
        let session = try await client.auth.session
        return Users(id: session.user.id.uuidString, email: session.user.email, name: "RanggaOke")
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws -> Users {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        return Users(id: session.user.id.uuidString, email: session.user.email, name: "RanggaOke")
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}


