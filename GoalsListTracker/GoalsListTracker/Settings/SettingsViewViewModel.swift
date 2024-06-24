//
//  SettingsViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import Foundation

@MainActor
final class SettingsViewViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let user = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = user.email
        else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "PASSWORD123" // TODO: update UI
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        let email = "EMAIL123" // TODO: update UI
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
}
