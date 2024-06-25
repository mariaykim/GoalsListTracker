//
//  ProfileViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation

final class ProfileViewViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}
