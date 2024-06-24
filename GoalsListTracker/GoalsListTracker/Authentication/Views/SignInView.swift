//
//  SignInView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with email")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            GoogleSignInButton(viewModel: .init(scheme: .light, style: .standard, state: .normal), action: {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            })
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(true))
    }
}
