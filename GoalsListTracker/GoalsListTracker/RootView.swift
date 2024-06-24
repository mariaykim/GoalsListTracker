//
//  RootView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/21/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                SignInView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
