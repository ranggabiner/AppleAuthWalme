//
//  ContentView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI

struct ContentView: View {
    @State var appUser: AppUser? = nil
    @State private var showSignInDetails = false
    
    var body: some View {
        ZStack {
            if let appUser = appUser {
                if showSignInDetails || appUser.nickname == nil || appUser.targetSteps == nil {
                    SignInDetailsView(appUser: $appUser, viewModel: HomeViewModel(appUser: appUser), showSignInDetails: $showSignInDetails)
                } else {
                    HomeView(viewModel: HomeViewModel(appUser: appUser), appUser: $appUser)
                }
            } else {
                SignInView(appUser: $appUser)
                    .onChange(of: appUser) { newUser in
                        if newUser != nil {
                            showSignInDetails = true
                        }
                    }
            }
        }
        .onAppear {
            Task {
                self.appUser = try? await AuthManager.shared.getCurrentSession()
            }
        }
    }
}


#Preview {
    ContentView(appUser: nil)
}
