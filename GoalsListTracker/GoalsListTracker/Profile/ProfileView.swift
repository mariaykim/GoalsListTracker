//
//  ProfileView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("userId: \(user.userId)")
                
                Button {
                    viewModel.toggleUserPremiumStatus()
                } label: {
                    Text("Premium User: \((user.isPremium ?? false).description.capitalized)")
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                NavigationLink(destination: {
                    SettingsView(showSignInView: $showSignInView)
                }, label: {
                    Image(systemName: "gear")
                        .font(.headline)
                })
            })
        }
    }
}

#Preview {
    ProfileView(showSignInView: .constant(false))
}
