//
//  SignInView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView()
            } label: {
                Text("Sign In with email")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
