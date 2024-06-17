//
//  ContentView.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//

import SwiftUI

struct ContentView: View {
    @State var appUser: Users? = nil
    @State private var showSignInDetails = false
    
    var body: some View {
        ZStack {
            if let appUser = appUser {
                VStack {
                    CreateNameView(viewModel: CreateNameViewModel(appUser: appUser), appUser: $appUser)
                    UpdateNameView(viewModel: UpdateNameViewModel(appUser: appUser), appUser: $appUser)
                    HomeView(viewModel: HomeViewModel(appUser: appUser), appUser: $appUser)
                }
            } else {
                SignInView(appUser: $appUser)        
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
