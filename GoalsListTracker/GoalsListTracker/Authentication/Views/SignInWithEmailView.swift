//
//  SignInWithEmailView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//


import SwiftUI

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(.rect(cornerRadius: 10))
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(.rect(cornerRadius: 10))
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .clipShape(.rect(cornerRadius: 10))
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
