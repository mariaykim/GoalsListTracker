//
//  GoogleSignInHelper.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class GoogleSignInHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() // grabbing top view controller
        else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString
        else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        
        return tokens
    }
}
