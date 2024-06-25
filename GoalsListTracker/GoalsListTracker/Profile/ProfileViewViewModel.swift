//
//  ProfileViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation

@MainActor
final class ProfileViewViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        print("authdata \(authDataResult)")
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        print("\(user)")
    }
    
    func toggleUserPremiumStatus() {
        guard let user else { return }
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(user: user, isPremium: !(currentValue))
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
}
