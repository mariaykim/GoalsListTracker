//
//  SignInEmailViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class SignInEmailViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    func signUp() async throws {
        guard validate() else { return }
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard validate() else { return }
        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
                
    func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".")
        else {
            errorMessage = "Please provide valid email"
            return false
        }
        
        return true
    }
}
