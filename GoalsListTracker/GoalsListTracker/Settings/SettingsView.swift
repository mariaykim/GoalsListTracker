//
//  SettingsView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = SettingsViewViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Sign out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }.foregroundStyle(Color.red)
            
            if viewModel.authProviders.contains(.email) {
                emailSettingsSectionView
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}

extension SettingsView {
    
    var emailSettingsSectionView: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("password reset success")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("password update success")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("update email success")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Settings")
        }
    }
}
