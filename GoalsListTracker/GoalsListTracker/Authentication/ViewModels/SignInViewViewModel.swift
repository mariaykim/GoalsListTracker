//
//  SignInViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation

@MainActor
final class SignInViewViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signIn()
        
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let dbUser = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: dbUser)
    }
}
