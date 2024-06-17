//
//  UpdateNameViewModel.swift
//  AppleAuthWalme
//
//  Created by Rangga Biner on 17/06/24.
//


import Foundation

class UpdateNameViewModel: ObservableObject {
    @Published var appUser: Users?

    init(appUser: Users?) {
        self.appUser = appUser
    }
    

}
